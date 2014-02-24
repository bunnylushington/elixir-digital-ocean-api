defmodule DropletTest do
  use ExUnit.Case

  if System.get_env("DIGOC_DROPLET_TEST") do
    test "droplet manipulation" do
      region_id = 1             # nyc
      size_id = 66              # very small!
      image_id = 350076         # ubuntu 13.04/x64
      name = "apitest"
      backups = false
      private_networking = false
      ssh_key_ids = [79152]     # a priv key

      droplet = DigOc.droplets :new, 
                      region_id: region_id,
                      size_id: size_id,
                      image_id: image_id,
                      name: name,
                      backups: backups,
                      private_networking: private_networking,
                      ssh_key_ids: ssh_key_ids

      assert is_record(droplet, DigOc.Droplet)
      assert droplet.name == name
      assert is_integer(droplet.event_id)
    end
  end

  test "reboot droplet" do
    droplet = DigOc.droplet("apitest") |> hd
    event_id = DigOc.droplets droplet.id, :reboot
    assert is_integer(event_id)
    
    event = DigOc.events event_id
    assert is_record(event, DigOc.Event)
    assert DigOc.event_progress(event) == :ok
  end

  test "powercycle droplet" do
    droplet = DigOc.droplet("apitest") |> hd
    event_id = DigOc.droplets droplet.id, :power_cycle
    assert is_integer(event_id)
    
    event = DigOc.events event_id
    assert is_record(event, DigOc.Event)
    assert DigOc.event_progress(event) == :ok
  end
    
  
end
