defmodule ImageTest do
  use ExUnit.Case

  if System.get_env("DIGOC_DROPLET_TEST") do
    test "snapshot manipulation" do

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


      DigOc.event_progress droplet.event_id

      assert is_record(droplet, DigOc.Droplet)
      assert droplet.name == name


      # -- take a snapshot.
      snap = DigOc.take_snapshot droplet.id, "auto-test-snap"
      assert is_record(snap, DigOc.Image)
      
      # -- retrieve the snapshot.
      other_snap = DigOc.images snap.id
      assert is_record(other_snap, DigOc.Image)
      assert other_snap == snap

      # -- transfer to other region.
      new_region = 4 # alternate NYC region
      DigOc.event_progress(DigOc.images snap.id, :transfer, new_region)
      image = DigOc.images snap.id
      assert is_record(image, DigOc.Image)
      assert Enum.member?(image.regions, 4) # nyc2
      assert Enum.member?(image.regions, 1) # nyc1

      # -- destroy image.
      :ok = DigOc.images snap.id, :destroy
      
      # -- decomission snapshot.
      DigOc.droplets droplet.id, :destroy
      
    end
  end  
end