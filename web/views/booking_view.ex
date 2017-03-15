defmodule SpreedlyAirlines.BookingView do
  use SpreedlyAirlines.Web, :view

  def error_summary(changeset) do
    if nil != changeset.errors[:base] do
      {msg, _opts} = changeset.errors[:base]
      msg
    else
      "Oops, something went wrong! Please check the errors below."
    end
  end

end
