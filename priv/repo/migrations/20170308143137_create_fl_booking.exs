defmodule SpreedlyAirlines.Repo.Migrations.CreateFlBooking do
  use Ecto.Migration

  def change do
    create table(:bookings) do
      add :status_message, :string
      add :username, :string
      add :amount, :float
      add :payment_token, :string
      add :flight_id, references(:flights, on_delete: :nothing)

      timestamps()
    end
    create index(:bookings, [:flight_id])

  end
end
