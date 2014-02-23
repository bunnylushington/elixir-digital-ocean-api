defmodule DigOc.Convert do

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
