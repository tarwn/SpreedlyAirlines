defmodule SpreedlyAirlines.FlightController do
  use SpreedlyAirlines.Web, :controller

  alias SpreedlyAirlines.Flight

  def index(conn, _params) do
    flights = Repo.all(Flight)
    render(conn, "index.html", flights: flights)
  end

  def show(conn, %{"id" => id}) do
    flight = Repo.get!(Flight, id)
    render(conn, "show.html", flight: flight)
  end

end
