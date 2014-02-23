defmodule DigOc.Utility do

  def client_id, do: System.get_env("DIGITAL_OCEAN_CLIENT_ID")
  def api_key,   do: System.get_env("DIGITAL_OCEAN_API_KEY")

  def url, do: "https://api.digitalocean.com/"

  def path(""), do: ""
  def path([]), do: ""
  def path(parts), do: Enum.join(parts, "/")
  
  def auth, do: "client_id=#{ client_id }&api_key=#{ api_key }"

  def qs(params), do: "?" <> URI.encode_query params
    

end
