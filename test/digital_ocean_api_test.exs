defmodule DigitalOceanApiTest do
  use ExUnit.Case

  test "client id retrieved" do
    assert DigOc.Utility.client_id
  end

  test "api key retrieved" do
    assert DigOc.Utility.api_key
  end

  test "url correct" do
    assert DigOc.Utility.url == "https://digitalocean.com/"
  end

  test "path fabricated correctly" do
    path = "a/b/c"
    assert DigOc.Utility.path(["a", "b", "c"]) == path
    assert DigOc.Utility.path(['a', 'b', 'c']) == path
    assert DigOc.Utility.path([:a, :b, :c])    == path
    assert DigOc.Utility.path("") == ""
    assert DigOc.Utility.path([]) == ""
  end

  test "url fabricated correctly" do
    url_prefix = DigOc.Utility.url <> "a/b/c?client_id"
    parts = [:a, :b, :c]
    url = DigOc.Utility.make_url(parts)
    {pos, _} = :binary.match(url, url_prefix)
    assert pos == 0
    assert :binary.match(url, "api_key") != :nomatch
  end

end
