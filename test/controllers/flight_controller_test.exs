defmodule SpreedlyAirlines.FlightControllerTest do
  use SpreedlyAirlines.ConnCase

  alias SpreedlyAirlines.Flight
  @valid_attrs %{arrival_airport: "some content", arrival_time: %{hour: 14, min: 0, sec: 0}, departure_airport: "some content", departure_time: %{hour: 14, min: 0, sec: 0}, price: "120.5"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, flight_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing flights"
  end

  test "shows chosen resource", %{conn: conn} do
    flight = Repo.insert! %Flight{}
    conn = get conn, flight_path(conn, :show, flight)
    assert html_response(conn, 200) =~ "Flight Details:"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, flight_path(conn, :show, -1)
    end
  end

end
