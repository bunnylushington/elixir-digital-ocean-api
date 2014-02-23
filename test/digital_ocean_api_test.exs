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

  test "add ssh key" do
    key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDSAFOCkXC61jeb/L8FeDn8nfb5bre5ph3a1vvHWvs7amQw7JIgy3rP6uqPZabJCNWxGdORGP5lNNwdQ1s7hdteQvoUlPTg1WXFr7ZJ9pUNuAB0nyasY+7tEzJWJvXAUx7eZOhxI7qfgH0E9AAkMpqZ6o9uQfu2Ov8uAj2tXQNtXbkn0N4jOXqJvIXY9MJu7/FTH6TReeQyJoUfUAhlDWXmtE+T7YySyVDzOprM41tXGY5KUYgPQUAWXNVzAkMdlLf6dU9HIRvzEgYMkL+ka0W25gEaQlgas8gahkDuKVaT/5WkOcEaf3HnM+NMNPwXw626IB/w/Y9BCTHczDspoKbB montuori@joe-cool.local"
    res = DigOc.ssh_keys :add, [name: "testkey", ssh_pub_key: key]
    assert res["status"] == "OK"
  end

  test "get ssh key id for label" do
    assert is_integer(DigOc.Utility.ssh_key_id("testkey"))
    assert DigOc.Utility.ssh_key_id(1234) == 1234
  end

  test "get ssh key" do
    res = DigOc.ssh_keys :get, "testkey"
    assert res["status"] == "OK"
  end


end
