defmodule Adventure.Map do
  def register_name(name, process_id) when is_pid(process_id) do
    has_key_or_value = Agent.get(__MODULE__,  fn state ->
      Enum.find(state, nil, fn {k,v} -> k == name || v == process_id end)
    end)

    if nil == has_key_or_value do
      Agent.update(__MODULE__, &(Map.put(&1, name, process_id)))
      :yes
    else
      :no
    end
  end

  def unregister_name(name) do
    Agent.get_and_update(__MODULE__, fn state ->
      { Map.get(state, name), Map.delete(state, name) }
    end)
  end

  def whereis_name(name) do
    case Agent.get(__MODULE__, &(Map.get(&1, name))) do
      pid when is_pid(pid) ->
        pid
      _ ->
        :undefined
    end
  end

  def send(name, message) do
    case Agent.get(__MODULE__, &(Map.get(&1, name))) do
      pid when is_pid(pid) ->
        Kernel.send(pid, message)
      _ ->
        {:badarg, {name, message}}
    end
  end

  def start_link() do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end
end