defmodule AdvDropletTest do
  use ExUnit.Case

  if System.get_env("DIGOC_DROPLET_TEST") do
   
    test "advanced droplet manipulation" do
      region_id = 1             # nyc
      size_id = 66              # very small!
      image_id = 350076         # ubuntu 13.04/x64
      name = "adv-apitest"
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
      assert DigOc.event_progress(droplet.event_id) == :ok

      droplet = DigOc.droplet("apitest")
      assert droplet == []
    end

  end
end