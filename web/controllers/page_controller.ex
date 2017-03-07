defmodule SpreedlyAirlines.PageController do
  use SpreedlyAirlines.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
