defmodule Adventure.Actions do
  alias Adventure.{Game, World, Player, Room, Item}

  def apply_action(game, %{action: :quit}) do
    {%Adventure.Game{game | done: true}, []}
  end

  def apply_action(game, %{action: :look}) do
    room = World.get_room(game.world, game.location)
    {game, [Adventure.Renderer.render_room(room)]}
  end

  def apply_action(game, %{action: :destroy, subject: :wizard}) do
    {
      game,
      [
        "The wizard waves his hand in his sleep and your attack is rebuffed.\n",
        "He grumbles to himself and goes back to snoring."
      ]
    }
  end

  def apply_action(game, %{action: :inventory}) do
    {game, [Adventure.Renderer.render_inventory(game.player)]}
  end

  def apply_action(%Game{location: :living_room} = game, %{action: :take, subject: :wizard}) do
    {game, ["Something about the wizard robs you of your will to lift him."]}
  end

  def apply_action(game, %{action: :take, subject: item}) do
    room = World.get_room(game.world, game.location)
    name = Item.get_name(item, true)

    if Room.contains_item?(room, item) do
      {Game.pick_up_item(game, item), ["You picked up #{name}"]}
    else
      {game, ["You don't see #{name} here"]}
    end
  end

  def apply_action(game, %{action: :drop, subject: item}) do
    name = Item.get_name(item, false)

    if(Player.has_item?(game.player, item)) do
      {Game.drop_item(game, item), ["You dropped the #{name}"]}
    else
      {game, ["You are not carrying the #{name}"]}
    end
  end

  def apply_action(%Game{location: :attic} = game, %{
        action: :weld,
        subject: :bucket,
        object: :chain
      }) do
    do_welding(game)
  end

  def apply_action(%Game{location: :attic} = game, %{
        action: :weld,
        subject: :chain,
        object: :bucket
      }) do
    do_welding(game)
  end

  def apply_action(game, %{action: :weld}) do
    {game, ["There is no welding equipment here."]}
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

  defp do_welding(game) do
    with {^game, []} <- verify_bucket(game),
         {^game, []} <- verify_chain(game) do
      {
        game
        |> update_in([Access.key(:player)], &Player.drop(&1, :bucket))
        |> update_in([Access.key(:player)], &Player.drop(&1, :chain))
        |> update_in([Access.key(:player)], &Player.pick_up(&1, :welded_bucket)),
        ["The chain is now securely welded to the bucket"]
      }
    else
      result -> result
    end
  end

  defp verify_bucket(game) do
    if Player.has_item?(game.player, :bucket) do
      {game, []}
    else
      {game, ["You aren't carrying the bucket."]}
    end
  end

  def verify_chain(game) do
    if Player.has_item?(game.player, :chain) do
      {game, []}
    else
      {game, ["You aren't carrying the chain."]}
    end
  end
end
