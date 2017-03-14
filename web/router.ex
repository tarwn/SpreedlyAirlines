defmodule SpreedlyAirlines.Router do
  use SpreedlyAirlines.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SpreedlyAirlines do
    pipe_through :browser # Use the default browser stack

    get "/", FlightController, :index
    get "/flights/:id", FlightController, :show
    get "/book/:flight_id", BookingController, :new
    post "/book/", BookingController, :create
    put "/book/", BookingController, :create      # this is on purpose, every additional attempt is logged as a new transaction
    get "/receipt/:id", BookingController, :show

    get "/log", TransactionController, :index
    get "/log/:id", TransactionController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", SpreedlyAirlines do
  #   pipe_through :api
  # end
end
