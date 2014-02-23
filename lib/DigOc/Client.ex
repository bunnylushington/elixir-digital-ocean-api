defmodule DigOc.Client do
  import DigOc.Utility, only: [url: 0, auth: 0, qs: 1]
  use HTTPotion.Base

  def process_url(path) do
    url <> path <> case String.contains?(path, "?") do
                     true -> "&" <> auth
                     false -> "?" <> auth
                   end
  end

  def process_response_body(body) do
    JSON.decode to_string(body)
  end
  
end
