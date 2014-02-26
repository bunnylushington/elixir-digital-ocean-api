defmodule AdvDropletTest do
  use ExUnit.Case

  defmacro test_event(evt, drop) do
    quote do
      droplet = DigOc.droplet(unquote(drop)) |> hd
      event_id = DigOc.droplets droplet.id, unquote(evt)
      assert is_integer(event_id)
      
      event = DigOc.events event_id
      assert is_record(event, DigOc.Event)
      assert DigOc.event_progress(event) == :ok
    end
  end

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
      id = droplet.id

      snap = DigOc.take_snapshot id, "auto-test-snap"
      assert is_record(snap, DigOc.Image)
      
      restore = hd(DigOc.restore id, snap)
      assert is_record(restore, DigOc.Droplet)

      rebuild = hd(DigOc.rebuild id, snap)
      assert is_record(rebuild, DigOc.Droplet)
      assert rebuild.image_id == snap.id

      size_id = 63 # 1GB instance
      resize = hd(DigOc.resize id, size_id)
      assert is_record(resize, DigOc.Droplet)
      assert resize.size_id == size_id

      # -- delete test droplet
      test_event :destroy, id
      droplet = DigOc.droplet(id)
      assert droplet == []
    end

  end
end