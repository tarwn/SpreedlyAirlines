defmodule SpreedlyAirlines.Repo.Migrations.AddFieldsToBooking do
  use Ecto.Migration

  def change do
    alter table(:bookings) do
      add :purchase_gateway_transaction_id, :string
      add :purchase_succeeded, :bool
      add :purchase_at, :utc_datetime
      add :purchase_payment_method_token, :string
      add :purchase_payment_method_number, :string
    end
  end
end
