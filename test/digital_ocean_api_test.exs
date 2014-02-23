defmodule DigitalOceanApiTest do
  use ExUnit.Case

  HTTPotion.start

  test "client id retrieved" do
    assert DigOc.Utility.client_id
  end

  test "api key retrieved" do
    assert DigOc.Utility.api_key
  end

  test "url correct" do
    assert DigOc.Utility.url == "https://api.digitalocean.com/"
  end

  test "path fabricated correctly" do
    path = "a/b/c"
    assert DigOc.Utility.path(["a", "b", "c"]) == path
    assert DigOc.Utility.path(['a', 'b', 'c']) == path
    assert DigOc.Utility.path([:a, :b, :c])    == path
    assert DigOc.Utility.path("") == ""
    assert DigOc.Utility.path([]) == ""
  end
  
  test "query string creation" do
    params = [foo: "bar", baz: "quux"]
    qs = "?foo=bar&baz=quux"
    assert DigOc.Utility.qs(params) == qs
 end

  test "/droplets" do
    res = DigOc.droplets
    assert res["status"] == "OK"
  end
  
  test "/regions" do
    res = DigOc.regions
    assert res["status"] == "OK"
  end

  test "/images" do
    res = DigOc.images
    assert res["status"] == "OK"
  end

  test "/ssh_keys" do
    res = DigOc.ssh_keys
    assert res["status"] == "OK"
  end

  test "create, lookup, destroy ssh key" do
    key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDSAFOCkXC61jeb/L8FeDn8nfb5bre5ph3a1vvHWvs7amQw7JIgy3rP6uqPZabJCNWxGdORGP5lNNwdQ1s7hdteQvoUlPTg1WXFr7ZJ9pUNuAB0nyasY+7tEzJWJvXAUx7eZOhxI7qfgH0E9AAkMpqZ6o9uQfu2Ov8uAj2tXQNtXbkn0N4jOXqJvIXY9MJu7/FTH6TReeQyJoUfUAhlDWXmtE+T7YySyVDzOprM41tXGY5KUYgPQUAWXNVzAkMdlLf6dU9HIRvzEgYMkL+ka0W25gEaQlgas8gahkDuKVaT/5WkOcEaf3HnM+NMNPwXw626IB/w/Y9BCTHczDspoKbB montuori@joe-cool.local"

    # -- add the key
    res = DigOc.ssh_keys :add, name: "testkey2", ssh_pub_key: key
    assert res["status"] == "OK"

    # -- lookup the key's id
    id = DigOc.Utility.ssh_key_id("testkey2")
    assert is_integer(id)

    # -- fetch the key
    res = DigOc.ssh_keys id
    assert res["status"] == "OK"

    # -- edit the key
    res = DigOc.ssh_keys id, :edit, ssh_pub_key: key
    assert res["status"] == "OK"
    
    # -- delete the key
    res = DigOc.ssh_keys id, :destroy
    assert res["status"] == "OK"

    # -- ensure the key is deleted
    res = DigOc.ssh_keys id, :destroy
    assert res["status"] == "ERROR"
  end
    
  
  test "get sizes" do
    res = DigOc.sizes
    assert res["status"] == "OK"
  end
  

end
