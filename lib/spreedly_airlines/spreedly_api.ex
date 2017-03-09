defmodule SpreedlyAirlines.SpreedlyApi do

  @url "https://core.spreedly.com/v1/"
  @gateway_token "LlkjmEk0xNkcWrNixXa1fvNoTP4"
  @environment_key "NlhD19h3k4etrJ9xFeXfe4AMN1b"
  @api_secret "NTOqEZEhiuAoWO4RH1dZXDg14k8aykbSjDSp7XPthKIxkubog5ptn79L4w2S4sT6"

  def purchase(payment_method_token, amount, currency_code, retain_on_success) do
    url = @url <> "gateways/" <> @gateway_token <> "/purchase.json"
    headers = [{"Accept", "application/json"}]
    options = [
      [hackney: [basic_auth: {@environment_key, @api_secret}]]
    ]

    message = [
      transaction: [
        payment_method_token: payment_method_token,
        amount: amount,
        currency_code: currency_code,
        retain_on_success: retain_on_success
      ]
    ]
    body = Poison.encode! message

    case HTTPoison.post(url, body, headers, options) do
      {:ok, %HTTPoison.Response{status_code: 200, body: response_body}} ->
        {:ok, Poison.decode!(response_body) }
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

end
