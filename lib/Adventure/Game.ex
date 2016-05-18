defmodule Adventure.Game do
  import Supervisor.Spec

  alias Adventure.Entity.Player
  alias Adventure.MapSupervisor

  def start_link() do
    children = [
      worker(Player, []),
      supervisor(MapSupervisor, []),
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: __MODULE__)
  end

  def player(game) do
    child_by_id(game, Player)
  end

  def map(game) do
    child_by_id(game, Map)
  end

  defp child_by_id(game, which_child_id) do
    case Enum.find(Supervisor.which_children(game), fn({child_id, _, _, _}) -> child_id == which_child_id end ) do
      {_, child_pid, _, _} -> child_pid
      _ -> nil
    end
  end
end