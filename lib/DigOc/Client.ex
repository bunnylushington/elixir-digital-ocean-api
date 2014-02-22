defmodule DigOc.Client do
  import DigOc.Utility, only: [url: 0, auth: 0]
  use HTTPotion.Base
  
  def process_url(path), do: url <> path <> auth
end
