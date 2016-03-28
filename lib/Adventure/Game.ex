defmodule Adventure.Game do
  import Supervisor.Spec

  alias Adventure.Entity.Player
  alias Adventure.Game.CommandProcessor

  def start_link() do
    children = [
      worker(Player, [], id: Player),
      supervisor(CommandProcessor, [], id: CommandProcessor)
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: __MODULE__)
  end

  def player(game) do
    child_by_id(game, Player)
  end

  def command_processor(game) do
    child_by_id(game, CommandProcessor)
  end

  defp child_by_id(game, which_child_id) do
    case Enum.find(Supervisor.which_children(game), fn({child_id, _, _, _}) -> child_id == which_child_id end ) do
      {_, child_pid, _, _} -> child_pid
      _ -> nil
    end
  end
end