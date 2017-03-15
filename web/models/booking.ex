defmodule SpreedlyAirlines.Booking do
  use SpreedlyAirlines.Web, :model
  import Number.Currency

  schema "bookings" do
    field :status_message, :string
    field :username, :string
    field :amount, :float
    field :retain_cc, :boolean
    field :payment_token, :string
    field :purchase_gateway_transaction_id, :string
    field :purchase_succeeded, :boolean
    field :purchase_at, :utc_datetime
    field :purchase_payment_method_token, :string
    field :purchase_payment_method_number, :string

    belongs_to :flight, SpreedlyAirlines.Flight

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:status_message, :username, :amount, :retain_cc, :payment_token, :purchase_gateway_transaction_id,
                     :flight_id, :purchase_succeeded, :purchase_at, :purchase_payment_method_token,
                     :purchase_payment_method_number])
    |> validate_required([:status_message, :username, :amount, :retain_cc, :payment_token, :flight_id])
  end

  def formatted_price(%SpreedlyAirlines.Booking{amount: price}), do: number_to_currency(price)

end
