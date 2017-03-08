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
    changeset = Booking.changeset(%Booking{}, booking_params)

    case Repo.insert(changeset) do
      {:ok, booking} ->
        conn
        |> put_flash(:info, "Booking created successfully.")
        |> redirect(to: booking_path(conn, :show, booking.id))
      {:error, changeset} ->
        flight = Repo.get!(Flight, booking_params["flight_id"])
        render(conn, "new.html", changeset: changeset, flight: flight)
    end
  end

  def show(conn, %{"id" => id}) do
    booking = Repo.get!(Booking, id)
    render(conn, "show.html", booking: booking)
  end

end
