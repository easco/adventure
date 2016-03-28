defmodule Adventure.Game.HandleCommand do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [])
  end

  def init() do
    {:ok, nil}
  end

  def handle_call({ :handle_command, command_text }, _from, state) do
    IO.puts("Handling a command - #{command_text}")
    {:stop, :normal, {:ok}, state}
  end

end