defmodule DigOc.Utility do

  def client_id, do: System.get_env("DIGITAL_OCEAN_CLIENT_ID")
  def api_key,   do: System.get_env("DIGITAL_OCEAN_API_KEY")

  def url, do: "https://digitalocean.com/"

  def path(""), do: ""
  def path([]), do: ""
  def path(parts), do: Enum.join(parts, "/")
  
  def make_url(parts) do
    url <> path(parts) <> "?client_id=#{ client_id }&api_key=#{ api_key }"
  end

end
