defmodule SpreedlyAirlines.Repo.Migrations.CreateFlight do
  use Ecto.Migration

  def change do
    create table(:flights) do
      add :departure_airport, :string
      add :arrival_airport, :string
      add :departure_time, :time
      add :arrival_time, :time
      add :price, :float

      timestamps()
    end

  end
end
