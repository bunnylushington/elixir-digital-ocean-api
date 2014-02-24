defmodule DigOc do
  import DigOc.Utility, only: [qs: 1, ssh_key_id: 1]

  # -------------------------------------------------- /droplets
  defrecord Droplet,
    backups_active: nil,
    status: nil,
    private_ip_address: nil,
    name: nil,
    created_at: nil,
    image_id: nil,
    image: nil,
    locked: nil,
    id: nil,
    size_id: nil,
    size: nil,
    region_id: nil,
    region: nil,
    ip_address: nil

  def droplets do
    res = DigOc.Raw.droplets
    Enum.map res["droplets"], fn(d) -> DigOc.Convert.to_droplet_record(d) end
  end
    
  def droplet(name) when is_binary(name) do
    Enum.filter droplets, fn(d) -> d.name == name end
  end

  def droplet(id) when is_integer(id) do
    Enum.filter droplets, fn(d) -> d.id == id end
  end
  

  # -------------------------------------------------- /regions
  defrecord Region,
    name: nil,
    id: nil,
    slug: nil

  def regions do
    case DigOc.Cache.get :regions do
      :not_found ->
        res = DigOc.Raw.regions
        data = Enum.map res["regions"], 
                    fn(d) -> DigOc.Convert.to_region_record(d) end
        DigOc.Cache.update_cache :regions, data
      {:ok, data} -> data
    end
  end
  
  def region(id), do: DigOc.Cache.get(:regions, id, &DigOc.regions/0)

  # -------------------------------------------------- /images
  defrecord Image, 
    name: nil,
    distribution: nil,
    id: nil,
    region_slugs: [],
    slug: nil,
    public: nil,
    regions: nil
    
  def images do
    case DigOc.Cache.get :images do
      :not_found ->
        res = DigOc.Raw.images
        data = Enum.map res["images"], 
                    fn(d) -> DigOc.Convert.to_image_record(d) end
        DigOc.Cache.update_cache :images, data
      {:ok, data} -> data
    end
  end

  def image(id), do: DigOc.Cache.get(:images, id, &DigOc.images/0)


  # -------------------------------------------------- /ssh_keys
  #
  # NB: Still using the "raw" format here.
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
    case DigOc.Cache.get :sizes do
      :not_found ->
        res = DigOc.Raw.sizes
        data = Enum.map res["sizes"], 
                    fn(d) -> DigOc.Convert.to_size_record(d) end
        DigOc.Cache.update_cache :sizes, data
      {:ok, data} -> data
    end
  end
    
  def size(id), do: DigOc.Cache.get(:sizes, id, &DigOc.sizes/0)

end
