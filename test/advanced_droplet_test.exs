defmodule AdvDropletTest do
  use ExUnit.Case

  if System.get_env("DIGOC_DROPLET_TEST") do
   
    test "advanced droplet manipulation" do
      assert 1 == 1
    end

  end
end