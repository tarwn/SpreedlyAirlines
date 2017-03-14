defmodule SpreedlyAirlines.Repo.Migrations.AddCcRetainToBookings do
  use Ecto.Migration

  def change do
    alter table(:bookings) do
      add :retain_cc, :bool
    end
  end
end
