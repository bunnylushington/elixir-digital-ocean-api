defmodule DigOc.Utility do

  def client_id, do: System.get_env("DIGITAL_OCEAN_CLIENT_ID")
  def api_key,   do: System.get_env("DIGITAL_OCEAN_API_KEY")

  def url, do: "https://api.digitalocean.com/"

  def path(""), do: ""
  def path([]), do: ""
  def path(parts), do: Enum.join(parts, "/")
  
  def auth, do: "client_id=#{ client_id }&api_key=#{ api_key }"

  # -- for some reason the "?" screws up emacs's font-lock?
  def qs(params), do: "?" <> encode_query params #"?" 
  
  def encode_query(params) do
    URI.encode_query Enum.map(params, 
                               fn({k, v}) -> case is_list(v) do
                                               true -> {k, Enum.join(v, ",")}
                                               false -> {k, v}
                                             end
                               end)
  end

  def ssh_key_id(l) do
    case is_integer l do
      true -> l
      false -> rec = Enum.filter DigOc.ssh_keys, fn(r) -> r.name == l end
               case rec do
                 [] -> nil
                 _ -> hd(rec).id
               end
    end
  end
  
end
