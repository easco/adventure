defmodule Adventure.CommandProcessor do
  alias Adventure.Parser
  alias Adventure.Map
  alias Adventure.Entity.Room

  def process_command(game, command_text) do
    tokens = Parser.tokenize_line(command_text)
    parsed_command = Parser.parse(tokens, %{})
    handle_parsed_command(game, parsed_command)
  end

  def handle_parsed_command(game, %{action: :look}) do
      player =  Adventure.Game.player(game)

      # find out what room the player is in
      {:location, location} = Adventure.Component.Location.get(player)
      room = Map.whereis_name(location)

      IO.puts("\n#{Room.description(room)}\n")
  end

  def handle_parsed_command(_game, %{action: :destroy, object: :wizard}) do
      IO.puts("The wizard waves his hand in his sleep and your attack is rebuffed.  The wizard continues to sleep.")
  end

  def handle_parsed_command(_game, _) do
      IO.puts("I don't know how to do that")
  end
end