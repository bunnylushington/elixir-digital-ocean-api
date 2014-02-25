defmodule DigOc.App do
  use Application.Behaviour
  
  def start(_type, _args) do
    HTTPotion.start
    DigOc.Cache.Supervisor.start_link([])
  end

end