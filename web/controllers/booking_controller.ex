defmodule SpreedlyAirlines.BookingController do
  use SpreedlyAirlines.Web, :controller

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
      {:error, changeset} ->
        IO.inspect changeset
        flight = Repo.get!(Flight, booking_params["flight_id"])
        render(conn, "new.html", changeset: changeset, flight: flight)
      {:error, booking, error_message} ->
        changeset = Booking.changeset(booking)
        changeset = %{ Ecto.Changeset.add_error(changeset, :base, error_message) | action: :receipt }
        flight = Repo.get!(Flight, booking_params["flight_id"])
        render(conn, "new.html", changeset: changeset, flight: flight)
    end
  end

  def show(conn, %{"id" => id}) do
    booking = Repo.get!(Booking, id)
    render(conn, "show.html", booking: booking)
  end

  defp save_initial_booking(booking_params)  do
    changeset = Booking.changeset(%Booking{}, booking_params)

    case Repo.insert(changeset) do
      {:ok, booking} -> {:ok, booking}
      {:error, changeset} -> {:error, changeset }
    end
  end

  defp charge_for_booking(booking) do
    case SpreedlyAirlines.SpreedlyApi.purchase(booking.payment_token, booking.amount, "USD", false) do
      {:ok, response} ->
        {:ok, response}
      {:error, _error} ->
        #todo: expand this to provide more detail if a known good, humand readable error comes back from Spreedly
        {:error, booking, "An error occurred while performing your purchase."}
    end
  end

  defp save_purchase_details(booking, purchase_details) do
    changeset = Booking.changeset(booking, {})
    case Repo.update(changeset) do
      {:ok, _} -> {:ok}
      {:error, changeset} ->
        Ecto.Changeset.add_error(changeset, :base, "Your purchase was successful, but an error occurred while preparing the receipt.")
        {:error, changeset}
    end

  end

end
