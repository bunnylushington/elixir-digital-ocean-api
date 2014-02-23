defmodule DigOc.Cache.Supervisor do
  use Supervisor.Behaviour

  def start_link(cache) do
    :supervisor.start_link(__MODULE__, cache)
  end

  def init(cache) do
    children = [ worker(DigOc.Cache.Server, [cache]) ]
    supervise children, strategy: :one_for_one
  end
end

defmodule DigOc.Cache.Server do
  use GenServer.Behaviour

  def start_link(cache) do
    :gen_server.start_link({ :local, :cache }, __MODULE__, cache, [])
  end

  def init(cache) do
    { :ok, cache }
  end

  def handle_call(:get, _from, cache) do
    { :reply, cache, cache }
  end

end