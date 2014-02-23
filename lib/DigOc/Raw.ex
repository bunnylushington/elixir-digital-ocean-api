defmodule DigOc.Raw do

  def sizes do 
    {:ok, res} = DigOc.Client.get("/sizes").body
    res
  end

  def images do
    {:ok, res} = DigOc.Client.get("/images").body
    res
  end

end
