defmodule Adventure.Game.HandleCommand do
  use GenServer

  alias Adventure.Parser

  def start_link(game) do
    GenServer.start_link(__MODULE__, [game])
  end

  def init(game) do
    {:ok, game}
  end

  def handle_call({ :handle_command, command_text }, _from, game) do
    IO.puts("Handling a command - #{command_text}")
    IO.puts("Game is #{inspect game}")

    tokens = Parser.tokenize_line(command_text)
    parsed_command = Parser.parse(tokens, %{})

    handle_parsed_command(game, parsed_command)

    IO.puts("Result #{inspect parsed_command}")

    {:stop, :normal, {:ok}, game}
  end

  defp handle_parsed_command(game, parsed_command) do
    player =  Adventure.Game.player(game)
    Adventure.Component.ActionHandler.handle_parsed_command(player, parsed_command)
  end
end