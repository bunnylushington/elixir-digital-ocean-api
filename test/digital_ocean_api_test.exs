defmodule DigitalOceanApiTest do
  use ExUnit.Case

  test "client id retrieved" do
    assert DigOc.Utility.client_id
  end

  test "api key retrieved" do
    assert DigOc.Utility.api_key
  end

end
