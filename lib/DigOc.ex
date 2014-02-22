defmodule DigOc do


  # -- /droplets
  def droplets do
    {:ok, res} = DigOc.Client.get("/droplets").body
    res
  end



end
