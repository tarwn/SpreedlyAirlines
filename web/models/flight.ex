defmodule SpreedlyAirlines.Flight do
  use SpreedlyAirlines.Web, :model
  import Number.Currency

  schema "flights" do
    field :departure_airport, :string
    field :arrival_airport, :string
    field :departure_time, Ecto.Time
    field :arrival_time, Ecto.Time
    field :price, :float
    field :vendor, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:departure_airport, :arrival_airport, :departure_time, :arrival_time, :price, :vendor])
    |> validate_required([:departure_airport, :arrival_airport, :departure_time, :arrival_time, :price])
  end

  def formatted_price(%SpreedlyAirlines.Flight{price: price}), do: number_to_currency(price)

  def display_vendor(%SpreedlyAirlines.Flight{vendor: vendor}) when vendor == "" or is_nil(vendor), do: ""

  def display_vendor(%SpreedlyAirlines.Flight{vendor: vendor}) when vendor != "", do: " (" <> vendor <> ")"
end
