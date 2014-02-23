defmodule DigOc do
  import DigOc.Utility, only: [qs: 1, ssh_key_id: 1]

  # -------------------------------------------------- /droplets
  def droplets do
    {:ok, res} = DigOc.Client.get("/droplets").body
    res
  end

  # -------------------------------------------------- /regions
  def regions do
    {:ok, res} = DigOc.Client.get("/regions").body
    res
  end

  # -------------------------------------------------- /images
  def images do
    {:ok, res} = DigOc.Client.get("/images").body
    res
  end

  # -------------------------------------------------- /ssh_keys
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


  # -------------------------------------------------- /sizes
  defrecord Size, 
    cost_per_hour: nil, 
    cost_per_month: nil,
    name: nil, 
    id: nil,
    memory: nil,
    slug: nil,
    cpu: nil,
    disk: nil
  
  def sizes do
    res = DigOc.Raw.sizes
    Enum.map res["sizes"], fn(d) -> size_dict_to_record(d) end
  end

  def size_dict_to_record(d) do
    Size.new(cost_per_hour:  d["cost_per_hour"],
             cost_per_month: d["cost_per_month"],
             name:           d["name"],
             id:             d["id"],
             memory:         d["memory"],
             slug:           d["slug"],
             cpu:            d["cpu"],
             disk:           d["disk"])
  end
             

    
end
