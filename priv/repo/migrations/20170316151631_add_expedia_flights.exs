defmodule SpreedlyAirlines.Repo.Migrations.AddExpediaFlights do
  use Ecto.Migration

  def change do
    alter table(:flights) do
      add :vendor, :string
    end
  end
end
