defmodule DigOc.Convert do

  def to_droplet_record(d) do
    DigOc.Droplet.new(backups_active:     d["backups_active"],
                      status:             d["status"],
                      private_ip_address: d["private_ip_address"],
                      name:               d["name"],
                      created_at:         d["created_at"],
                      image_id:           d["image_id"],
                      image:              DigOc.image(d["image_id"]),
                      locked:             d["locked"],
                      id:                 d["id"],
                      size_id:            d["size_id"],
                      size:               DigOc.size(d["size_id"]),
                      region_id:          d["region_id"],
                      region:             DigOc.region(d["region_id"]),
                      ip_address:         d["ip_address"],
                      event_id:           d["event_id"])
  end

  def to_region_record(d) do
    DigOc.Region.new(name: d["name"],
                     id:   d["id"],
                     slug: d["slug"])
  end

  def to_image_record(d) do
    DigOc.Image.new(name:         d["name"],
                    distribution: d["distribution"],
                    id:           d["id"],
                    region_slugs: d["region_slugs"],
                    slug:         d["slug"],
                    public:       d["public"],
                    regions:      d["regions"])
  end

  def to_abbr_sshkey_record(d) do
    DigOc.SSHKey.new(id:   d["id"],
                     name: d["name"])
  end

  def to_sshkey_record(d) do
    DigOc.SSHKey.new(id:          d["id"],
                     name:        d["name"],
                     ssh_pub_key: d["ssh_pub_key"])
  end

  def to_size_record(d) do
    DigOc.Size.new(cost_per_hour:  d["cost_per_hour"],
                   cost_per_month: d["cost_per_month"],
                   name:           d["name"],
                   id:             d["id"],
                   memory:         d["memory"],
                   slug:           d["slug"],
                   cpu:            d["cpu"],
                   disk:           d["disk"])
  end

  def to_event_record(d) do
    DigOc.Event.new(id:            d["id"],
                    action_status: d["action_status"],
                    droplet_id:    d["droplet_id"],
                    event_type_id: d["event_type_id"],
                    percentage:    d["percentage"])
  end


  def to_cache_record(l), do: HashDict.new(Enum.map l, fn(r) -> {r.id, r} end)

end
