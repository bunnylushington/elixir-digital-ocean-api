defmodule DigOc do
  import DigOc.Utility, only: [qs: 1, ssh_key_id: 1]

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

  # -- /ssh_keys
  def ssh_keys do
    {:ok, res} = DigOc.Client.get("/ssh_keys").body
    res
  end

  def ssh_keys(:add, params) do
    {:ok, res} = DigOc.Client.get("/ssh_keys/new/" <> qs(params)).body
    res
  end

  def ssh_keys(:get, id) do
    {:ok, res} = DigOc.Client.get("/ssh_keys/#{ ssh_key_id id }").body
    res
  end

               
  

end
