defmodule SpreedlyAirlines.BookingController do
  use SpreedlyAirlines.Web, :controller
  require Logger

  alias SpreedlyAirlines.Booking
  alias SpreedlyAirlines.Flight

  def new(conn, %{"flight_id" => flight_id}) do
    changeset = Booking.changeset(%Booking{ flight_id: flight_id })
    flight = Repo.get!(Flight, flight_id)
    render(conn, "new.html", changeset: changeset, flight: flight)
  end

  def create(conn, %{"booking" => booking_params}) do
    with {:ok, booking} <- save_initial_booking(booking_params),
         {:ok, purchase_details} <- charge_for_booking(booking),
         {:ok} <- save_purchase_details(booking, purchase_details)
    do
       conn
       |> put_flash(:info, "Flight booked successfully.")
       |> redirect(to: booking_path(conn, :show, booking.id))
    else
      {:error, changeset} -> redisplay_form(conn, changeset, booking_params["flight_id"])
      {:api_error, booking, error_message} ->
        {:ok, changeset} = save_purchase_error(booking, error_message)
        changeset = %{ Ecto.Changeset.add_error(changeset, :base, error_message) | action: :purchase_failed }
        redisplay_form(conn, changeset, booking_params["flight_id"])
      {:error, booking, error_message} ->
        changeset = Booking.changeset(booking)
        changeset = %{ Ecto.Changeset.add_error(changeset, :base, error_message) | action: :purchase_failed }
        redisplay_form(conn, changeset, booking_params["flight_id"])
    end
  end

  def show(conn, %{"id" => id}) do
    booking = Repo.get!(Booking, id)
    flight = Repo.get!(Flight, booking.flight_id)
    render(conn, "show.html", booking: booking, flight: flight)
  end

  defp save_initial_booking(booking_params)  do
    changeset = Booking.changeset(%Booking{}, booking_params)

    case Repo.insert(changeset) do
      {:ok, booking} -> {:ok, booking}
      {:error, changeset} -> {:error, changeset }
    end
  end

  defp charge_for_booking(booking) do
    flight = Repo.get!(Flight, booking.flight_id)
    perform_charge(booking, flight.vendor)
  end

  defp perform_charge(booking, vendor) when vendor == "" or is_nil(vendor) do
    case SpreedlyAirlines.SpreedlyApi.purchase(booking.payment_token, booking.amount, "USD", booking.retain_cc) do
      {:ok, response} ->
        {:ok, response}
      {:api_error, _error_details} ->
        #todo: expand this to provide more detail if a known good, human readable error comes back from Spreedly
        {:api_error, booking, "We couldn't process the provided credit card, please try another or contact us at 555-555-5555."}
      {:error, _error} ->
        #todo: expand this to provide more detail if a known good, humand readable error comes back from Spreedly
        {:error, booking, "An error occurred while performing your purchase."}
    end
  end

  defp perform_charge(booking, vendor) when vendor != "" do
    case SpreedlyAirlines.SpreedlyApi.deliver_payment(booking.payment_token, booking.amount) do
      {:ok, response} ->
        IO.inspect response
        {:ok, response}
      {:api_error, _error_details} ->
        #todo: expand this to provide more detail if a known good, human readable error comes back from Spreedly
        {:api_error, booking, "We couldn't process the provided credit card, please try another or contact us at 555-555-5555."}
      {:error, _error} ->
        #todo: expand this to provide more detail if a known good, humand readable error comes back from Spreedly
        {:error, booking, "An error occurred while performing your purchase."}
    end
  end

  defp save_purchase_details(booking, purchase_details) do
    changeset = Booking.changeset(booking, %{
      status_message: "Payment Method Captured, Purchase Successful",
      purchase_gateway_transaction_id: purchase_details["transaction"]["gateway_transaction_id"],
      purchase_succeeded: purchase_details["transaction"]["succeeded"],
      purchase_at: purchase_details["transaction"]["updated_at"] |> NaiveDateTime.from_iso8601!,
      purchase_payment_method_token: purchase_details["transaction"]["payment_method"]["token"],
      purchase_payment_method_number: purchase_details["transaction"]["payment_method"]["number"]
    })

    case Repo.update(changeset) do
      {:ok, _} -> {:ok}
      {:error, changeset} ->
        Logger.error inspect(changeset.errors)
        changeset = Ecto.Changeset.add_error(changeset, :base, "Your purchase was successful, but an error occurred while preparing the receipt.")
        IO.inspect changeset
        IO.inspect Ecto.DateTime.cast!(purchase_details["transaction"]["updated_at"])
        {:error, changeset}
    end

  end

  defp save_purchase_error(booking, _error_message) do
    changeset = Booking.changeset(booking, %{
      status_message: "Payment Method Captured, Purchase Failure",
      purchase_succeeded: false,
      #purchase_at: Ecto.DateTime.cast!(purchase_details["transaction"]["updated_at"])
    })

    case Repo.update(changeset) do
      {:ok, _} -> {:ok, changeset}
      {:error, changeset} ->
        # let's assume chances of purchase failure + db save failure + still able to respond to user are prettty low
        {:error, changeset}
    end

  end

  defp redisplay_form(conn, changeset, flight_id) do
    flight = Repo.get!(Flight, flight_id)
    render(conn, "new.html", changeset: changeset, flight: flight)
  end


end
