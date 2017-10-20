defmodule Adventure.Renderer do
  alias Adventure.Room

  def bold(string) do
    [IO.ANSI.bright(), string, IO.ANSI.normal()]
  end

  def render_room(%Room{title: title, description: description} = room) do
    [bold(title), "\n\n", description, "\n", render_exits(room)]
  end

  def render_exits(room) do
    room.exits
    |> Enum.map(&render_exit/1)
  end

  def render_exit({direction, {description, _destination}}) do
    "A #{description} leads #{direction}\n"
  end

  def render_command_response(message) do
    IO.puts(message)
  end
end
