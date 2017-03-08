# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SpreedlyAirlines.Repo.insert!(%SpreedlyAirlines.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias SpreedlyAirlines.Repo
alias SpreedlyAirlines.Flight

Repo.insert! %Flight{
  departure_airport: "RDU",
  departure_time: %Ecto.Time{ hour: 12, min: 15, sec: 0 },
  arrival_airport: "BOS",
  arrival_time: %Ecto.Time{ hour: 13, min: 45, sec: 0 },
  price: 123.45
}

Repo.insert! %Flight{
  departure_airport: "RDU",
  departure_time: %Ecto.Time{ hour: 14, min: 5, sec: 0 },
  arrival_airport: "BOS",
  arrival_time: %Ecto.Time{ hour: 15, min: 30, sec: 0 },
  price: 109.99
}

Repo.insert! %Flight{
  departure_airport: "ABQ",
  departure_time: %Ecto.Time{ hour: 6, min: 50, sec: 0 },
  arrival_airport: "ATL",
  arrival_time: %Ecto.Time{ hour: 13, min: 50, sec: 0 },
  price: 400.0
}


Repo.insert! %Flight{
  departure_airport: "ABQ",
  departure_time: %Ecto.Time{ hour: 12, min: 15, sec: 0 },
  arrival_airport: "ATL",
  arrival_time: %Ecto.Time{ hour: 20, min: 45, sec: 0 },
  price: 574.0
}
