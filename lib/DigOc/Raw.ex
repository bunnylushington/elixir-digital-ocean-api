defmodule DigOc.Raw do

  def sizes do 
    {:ok, res} = DigOc.Client.get("/sizes").body
    res
  end


end
