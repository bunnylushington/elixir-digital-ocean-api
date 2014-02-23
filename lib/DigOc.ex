defmodule DigOc do


  # -- /droplets
  def droplets do
    {:ok, res} = DigOc.Client.get("/droplets").body
    res
  end

  # -- /regions
  def regions do
    {:ok, res} = DigOc.Client.get("/regions").body
    res
  end

  # -- /images
  def images do
    {:ok, res} = DigOc.Client.get("/images").body
    res
  end


end
