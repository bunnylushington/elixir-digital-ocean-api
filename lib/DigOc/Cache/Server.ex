defmodule DigOc.Cache.Supervisor do
  use Supervisor.Behaviour

  def start_link(args) do
    :supervisor.start_link(__MODULE__, args)
  end

  def init(args) do
    children = [ worker(DigOc.Cache.Server, [args]) ]
    supervise children, strategy: :one_for_one
  end
end

defmodule DigOc.Cache do
  def update_cache(datatype, data) do
    :gen_server.call(:cache, {:put, datatype, data})
  end

  def get(datatype) do
    :gen_server.call(:cache, {:get, datatype})
  end
  
  def get(datatype, id) do
    :gen_server.call(:cache, {:get, datatype, id})
  end

  def get(datatype, id, load_fn, retry \\ 0) do
    if retry > 2 do
      :not_found
    else
      case :gen_server.call(:cache, {:get, datatype, id}) do
        {:ok, val} -> val
        :not_found -> apply(load_fn, [])
                      get(datatype, id, load_fn, retry + 1)
      end
    end
  end

  def clear, do: :gen_server.cast(:cache, :clear)

end

defmodule DigOc.Cache.Server do
  use GenServer.Behaviour

  def start_link(args) do
    :gen_server.start_link({ :local, :cache }, __MODULE__, args, [])
  end

  def init(_args) do
    { :ok, HashDict.new }
  end

  def handle_call(:get, _from, cache) do
    { :reply, cache, cache }
  end

  def handle_call({:get, datatype}, _from, cache) do
    res = case Dict.get(cache, datatype) do
            nil -> :not_found
            vals -> {:ok, Dict.values vals}
          end
    { :reply, res, cache }
  end

  def handle_call({:get, datatype, id}, _from, cache) do
    res = case Dict.get(cache, datatype) do
      nil -> :not_found
      vals -> case Dict.get(vals, id) do
                nil -> :not_found
                val -> {:ok, val}
              end
    end
    { :reply, res, cache }
  end

  def handle_call({:put, datatype, data}, _from, cache) do
    new_cache = Dict.put cache, datatype, DigOc.Convert.to_cache_record(data)
    { :reply, data, new_cache }
  end

  def handle_cast(:clear, _cache), do: { :noreply, HashDict.new }

end