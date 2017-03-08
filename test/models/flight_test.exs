defmodule SpreedlyAirlines.FlightTest do
  use SpreedlyAirlines.ModelCase

  alias SpreedlyAirlines.Flight

  @valid_attrs %{arrival_airport: "some content", arrival_time: %{hour: 14, min: 0, sec: 0}, departure_airport: "some content", departure_time: %{hour: 14, min: 0, sec: 0}, price: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Flight.changeset(%Flight{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Flight.changeset(%Flight{}, @invalid_attrs)
    refute changeset.valid?
  end
end
