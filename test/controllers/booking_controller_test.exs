defmodule SpreedlyAirlines.BookingControllerTest do
  use SpreedlyAirlines.ConnCase

  alias SpreedlyAirlines.Booking
  @valid_attrs %{amount: "120.5", payment_token: "some content", status_message: "some content", username: "some content", flight_id: 1}
  @invalid_attrs %{}

  test "renders form for new resources", %{conn: conn} do
    #TODO how do I add an object or flight id here?
    conn = get conn, booking_path(conn, :new, 1)
    assert html_response(conn, 200) =~ "New booking"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, booking_path(conn, :create), booking: @valid_attrs
    assert redirected_to(conn) == booking_path(conn, :index)
    assert Repo.get_by(Booking, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    #TODO flight id, is it interacting w/ real DB? Do I need to seed it?
    conn = post conn, booking_path(conn, :create), booking: @invalid_attrs
    assert html_response(conn, 200) =~ "New booking"
  end

  test "shows chosen resource", %{conn: conn} do
    booking = Repo.insert! %Booking{}
    conn = get conn, booking_path(conn, :show, booking)
    assert html_response(conn, 200) =~ "Flight details:"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, booking_path(conn, :show, -1)
    end
  end
end
