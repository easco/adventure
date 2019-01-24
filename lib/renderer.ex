defmodule Adventure.Renderer do
  alias Adventure.{Room, Item}

  def bold(string) do
    [IO.ANSI.bright(), string, IO.ANSI.normal()]
  end

  def render_room(%Room{title: title, description: description} = room) do
    ["\n", bold(title), "\n\n", description, "\n", render_exits(room), "\n", render_items(room)]
  end

  def render_inventory(player) do
    inspect(player.inventory)
  end

  def render_exits(room) do
    room.exits
    |> Enum.map(&render_exit/1)
  end

  def render_items(room) do
    room.items
    |> Enum.map(&Item.get_item/1)
    |> Enum.map(&render_item/1)
  end

  def render_exit({direction, {description, _destination}}) do
    "A #{description} leads #{direction}\n"
  end

  def render_item(object) do
    "There is a #{object.name} here\n"
  end

  def render_command_response(message) do
    IO.puts(message)
  end
end
