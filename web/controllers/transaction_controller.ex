defmodule SpreedlyAirlines.TransactionController do
  use SpreedlyAirlines.Web, :controller

  alias SpreedlyAirlines.Booking
  alias SpreedlyAirlines.Flight

  def index(conn, _params) do
    bookings = Repo.all(Booking)
    render(conn, "index.html", bookings: bookings)
  end

  def show(conn, %{"id" => id}) do
    booking = Repo.get!(Booking, id)
    flight = Repo.get!(Flight, booking.flight_id)
    render(conn, "show.html", booking: booking, flight: flight)
  end

end
