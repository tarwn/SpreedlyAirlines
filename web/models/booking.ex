defmodule SpreedlyAirlines.Booking do
  use SpreedlyAirlines.Web, :model

  schema "bookings" do
    field :status_message, :string
    field :username, :string
    field :amount, :float
    field :payment_token, :string
    belongs_to :flight, SpreedlyAirlines.Flight

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:status_message, :username, :amount, :payment_token, :flight_id])
    |> validate_required([:status_message, :username, :amount, :payment_token, :flight_id])
  end
end
