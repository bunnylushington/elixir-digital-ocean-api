defmodule DigOc.Raw do

  def regions do
    {:ok, res} = DigOc.Client.get("/regions").body
    res
  end

  def sizes do 
    {:ok, res} = DigOc.Client.get("/sizes").body
    res
  end

  def images do
    {:ok, res} = DigOc.Client.get("/images").body
    res
  end

end
