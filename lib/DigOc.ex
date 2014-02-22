defmodule DigOc do


  # -- /droplets
  def droplets do
    res = DigOc.Client.get("/droplets")
  end



end
