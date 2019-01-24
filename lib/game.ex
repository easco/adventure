defmodule Adventure.Game do
  alias Adventure.{World, Player, Room}

  defstruct done: false, location: :living_room, world: World.new(), player: Player.new()

  def new(), do: %__MODULE__{}

  def pick_up_item(game, item) do
    game
    |> update_in([Access.key(:world), game.location], &Room.remove_item(&1, item))
    |> update_in([Access.key(:player)], &Player.pick_up(&1, item))
  end

  def drop_item(game, item) do
    game
    |> update_in([Access.key(:world), game.location], &Room.add_item(&1, item))
    |> update_in([Access.key(:player)], &Player.drop(&1, item))
  end
end
