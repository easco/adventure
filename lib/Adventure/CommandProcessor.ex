defmodule Adventure.CommandProcessor do
  import Supervisor.Spec

  def start_link(game) do
    children =  [
      worker(Adventure.Game.HandleCommand, [game], restart: :transient)
    ]

    Supervisor.start_link(children, strategy: :simple_one_for_one, name: __MODULE__)
  end

  def process_command(command_text) do
    {:ok, command_handler} = Supervisor.start_child(__MODULE__, [])
    GenServer.call(command_handler, {:handle_command, command_text})
  end
end