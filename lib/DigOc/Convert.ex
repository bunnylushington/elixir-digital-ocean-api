defmodule DigOc.Convert do

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

end
