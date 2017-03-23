defmodule Adventure.System.Renderer do
  def bold(string) do
    "#{IO.ANSI.bright()}#{string}#{IO.ANSI.normal()}"
  end

  def render_room(room) do
    %{title: title, description: description} = Adventure.Entity.components(room)

    "#{bold(title)}\n\n#{description}\n#{render_exits(room)}"
  end

  def render_exits(room) do
    room
      |> Adventure.Component.Exits.exit_list
      |> Enum.map(&render_exit/1)
      |> Enum.join("\n")
  end

  def render_exit({direction, {description, _destination}}) do
    "A #{description} leads #{direction}"
  end

  def render_command_response(message) do
    IO.puts(message)
  end
end
