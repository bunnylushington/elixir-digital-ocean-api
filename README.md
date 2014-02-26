# DigitalOcean API Client in Elixir

## Introduction

A pretty straightforward implementation of the [DigitalOcean
API](https://cloud.digitalocean.com/api_access) (login required) in
[Elixir](http://elixir-lang.org).  


## Documentation

To get started, be sure to set the environment variables
`DIGITAL_OCEAN_CLIENT_ID` and `DIGITAL_OCEAN_API_KEY`.  

This library closely follows the DigialOcean API document.  One
convenience provided is the trnaslation of JSON return structures into
Elixir records.  So

    event_record = DigOc.event event_id
    IO.puts event_record.action_status

and the like are possible.

### Droplets


* List all the droplets.

        droplet_list = DigOc.droplets


* Create a new droplet.

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

* Reboot a droplet.

        DigOc.droplets droplet.id, :reboot

* Power cycle a droplet.

        DigOc.droplets droplet.id, :powercycle

* Shutdown a droplet.

        DigOc.droplets droplet.id, :shutdown

* Power off a droplet.

        DigOc.droplets droplet.id, :power_off

* Power on a droplet.

        DigOc.droplets droplet.id, :power_on

* Reset a droplet password.

        DigOc.droplets droplet.id, :password_reset

* Destroy a droplet.

        DigOc.droplets droplet.id, :destroy


These functions require a running droplet to be powered off before
executing.  There are both plain methods that do not manipulate the
droplet first and convenience methods that will power off a running
server, perform the action, and power the server back on again (if it
was running).

* Resize a droplet.  The `size` parameter can be either a size record
  (as would be returned by `DigOc.sizes` or a size.id or size.slug.

        # plain
        evt = DigOc.droplets droplet.id, :resize, size

        # convenience
        droplet = DigOc.resize droplet, size


* Take a snapshot.

        # plain
        evt = DigOc.droplets droplet.id, :snapshot, snapshot_name

        # convenience
        new_image = DigOc.take_snapshot droplet, snapshot_name

* Restore a droplet from an image.  The `image` parameter can be
  either an image record (as would be returned by `DigOc.images` or an
  image.id or image.slug.

        # plain
        evt = DigOc.droplets droplet.id, :restore, image

        # convenience
        droplet = DigOc.restore droplet, image

* Rebuild a droplet from an image.  The `image` parameter is as above.

        # plain
        evt = DigOc.droplets droplet.id, :rebuild, image

        # convenience
        droplet = DigOc.rebuild droplet, image


    
### Regions

Note: Regions are cached.  If a new region becomes available it will
not appear in the region list until the cache is cleared.

* Get the available regions as a list of DigOc.Region records.

        regions = DigOc.regions

* Get the Region record for a given region_id.

        region = DigOc.region region_id


### Images

Note: Images are cached.  If a new image is created (by taking a
snapshot, say) the cache should be cleared afterwards.

* Get the available images as a list of DigOc.Image records.

        images = DigOc.images

* Get the Image record for a given image_id.

        image = DigOc.image image_id


### SSH Keys

* Get the available public SSH keys as a list of DigOc.SSHKey records.

        keys = DigOc.ssh_keys

* Get an ssh key by ID.

        key = DigOc.ssh_keys key_id

* Create a new SSH key.

        public_key = "ssh-rsa AAAAB3Nzac1...XXV user@example.com"
        key = DigOc.ssh_keys :add, name: "new key", ssh_pub_key: public_key

* Edit an SSH key.

        key = DigOc.ssh_keys sshkey.id, :edit, name: "new name"

* Destroy an SSH key.

        :ok = DigOc.ssh_keys sshkey.id, :destroy


### Sizes

Note: sizes are cached.  If a new size becomes available it not appear
in the size list until the cache is cleared.

* Get the available sizes as a list of DigOc.Size records.

        sizes = DigOc.sizes

* Get the Size record for a given size_id.

        size = DigOc.size size_id

### Events

* Get the DigOc.Event record for an event_id.

        evt = DigOc.events event_id

* Block until an event has a percentage of "100" or an action_status
  of "done".  Accepts either an Event record or event id.

        :ok = DigOc.event_progress event_record
        :ok = DigOc.event_progress event_id


### Cache

* To clear the cache (asynchronously):

        DigOc.Cache.clear


## Author

Kevin Montuori <montuori@gmail.com>
  
