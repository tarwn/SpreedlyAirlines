defmodule SpreedlyAirlines.BookingTest do
  use SpreedlyAirlines.ModelCase

  alias SpreedlyAirlines.Booking

  @valid_attrs %{amount: "120.5", payment_token: "some content", status_message: "some content", username: "some content", flight_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Booking.changeset(%Booking{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Booking.changeset(%Booking{}, @invalid_attrs)
    refute changeset.valid?
  end
end
