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

  def droplet_action(id, action, params \\ nil) do
      base = "/droplets/#{ id }/#{ action }"
      url = if nil?(params), do: base, else: base <> qs(params)
      {:ok, res} = DigOc.Client.get(url).body
      IO.puts inspect(res)
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

  def images(id, :transfer, params) do
    url = "/images/#{ id }/transfer" <> qs(params)
    {:ok, res} = DigOc.Client.get(url).body
    res
  end

  def images(id, :destroy) do
    {:ok, res} = DigOc.Client.get("/images/#{ id }/destroy").body
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
    {:ok, res} = DigOc.Client.get("/ssh_keys/#{ ssh_key_id id }/destroy").body
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

  def domains do
    {:ok, res} = DigOc.Client.get("/domains").body
    res
  end
  
  def domains(id) do
    {:ok, res} = DigOc.Client.get("/domains/#{ id }").body
    res
  end

  def domains(:new, params) do
    {:ok, res} = DigOc.Client.get("/domains/new" <> qs(params)).body
    res
  end

  def domains(id, :destroy) do
    {:ok, res} = DigOc.Client.get("/domains/#{ id }/destroy").body
    res
  end

  def domains(id, :records) do
    {:ok, res} = DigOc.Client.get("/domains/#{ id }/records").body
    res
  end

  def domains(id, :new_record, params) do
    url = "/domains/#{ id }/records/new" <> qs(params)
    {:ok, res} = DigOc.Client.get(url).body
    res
  end

  def domains(id, :records, record_id) do
    url = "/domains/#{ id }/records/#{ record_id }"
    {:ok, res} = DigOc.Client.get(url).body
    res
  end

  def domains(id, :destroy_record, record_id) do
    url = "/domains/#{ id }/records/#{ record_id}/destroy"
    {:ok, res} = DigOc.Client.get(url).body
    res
  end

  def domains(id, :edit_record, record_id, params) do
    url = "/domains/#{ id }/records/#{ record_id }/edit" <> qs(params)
    {:ok, res} = DigOc.Client.get(url).body
    res
  end

  def events(id) do
    {:ok, res} = DigOc.Client.get("/events/#{ id }/").body
    res
  end

end
