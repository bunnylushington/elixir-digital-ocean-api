defmodule DigOc.Client do
  import DigOc.Utility, only: [url: 0, auth: 0]
  use HTTPotion.Base
  
  def process_url(path), do: url <> path <> auth

  def process_response_body(body) do
    JSON.decode to_string(body)
  end
  
end
