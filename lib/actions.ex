defmodule Adventure.Actions do
  alias Adventure.World

  def apply_action(game, %{action: :quit}) do
    {%Adventure.Game{game | done: true}, []}
  end

  def apply_action(game, %{action: :look}) do
    room = World.get_room(game.world, game.location)
    {game, [Adventure.Renderer.render_room(room)]}
  end

  def apply_action(game, %{action: :destroy, object: :wizard}) do
    {
      game,
      [
        "The wizard waves his hand in his sleep and your attack is rebuffed.\n",
        "The wizard continues to sleep."
      ]
    }
  end

  def apply_action(game, %{action: :go, direction: direction}) do
    current_room = World.get_room(game.world, game.location)

    move_player(game, Keyword.get(current_room.exits, direction, :none))
  end

  def apply_action(game, _) do
    {game, ["I don't know how to do that"]}
  end

  defp move_player(game, {_description, destination}) do
    room = World.get_room(game.world, destination)
    {%Adventure.Game{game | location: destination}, [Adventure.Renderer.render_room(room)]}
  end

  defp move_player(game, :none) do
    {game, ["You cannot move in that direction."]}
  end
end
