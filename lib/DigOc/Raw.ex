defmodule DigOc.Raw do
  import DigOc.Utility, only: [ssh_key_id: 1, qs: 1]

  def droplets do
    {:ok, res} = DigOc.Client.get("/droplets").body
    res
  end

  def droplets(:new, params) do
    url = "/droplets/new" <> qs(params)
    {:ok, res} = DigOc.Client.get(url).body
    res
  end

  def droplets(id, :reboot) do
    {:ok, res} = DigOc.Client.get("/droplets/#{ id }/reboot").body
    res
  end

  def droplets(id, :power_cycle) do
    {:ok, res} = DigOc.Client.get("/droplets/#{ id }/power_cycle").body
    res
  end

  def regions do
    {:ok, res} = DigOc.Client.get("/regions").body
    res
  end

  def images do
    {:ok, res} = DigOc.Client.get("/images").body
    res
  end

  def ssh_keys do
    {:ok, res} = DigOc.Client.get("/ssh_keys").body
    res
  end

  def ssh_keys(id) do
    {:ok, res} = DigOc.Client.get("/ssh_keys/#{ ssh_key_id id }").body
    res
  end

  def ssh_keys(:add, params) do
    {:ok, res} = DigOc.Client.get("/ssh_keys/new/" <> qs(params)).body
    res
  end

  def ssh_keys(id, :destroy) do
    {:ok, res} = DigOc.Client.get("/ssh_keys/#{ ssh_key_id id}/destroy").body
    res
  end

  def ssh_keys(id, :edit, params) do
    url = "/ssh_keys/#{ ssh_key_id id }/edit/" <> qs(params)
    {:ok, res} = DigOc.Client.get(url).body
    res
  end

  def sizes do 
    {:ok, res} = DigOc.Client.get("/sizes").body
    res
  end

  def events(id) do
    {:ok, res} = DigOc.Client.get("/events/#{ id }/").body
    res
  end

end
