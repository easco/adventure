defmodule Adventure do

  alias Adventure.Game

  #
  # Escript main routine
  #
  def main(_args) do
    {:ok, _map} = Adventure.MapSupervisor.start_link()

    bold_welcome = Adventure.System.Renderer.bold("Welcome to Adventure!")
    IO.puts("#{bold_welcome}")

    command_loop(%Game{done: false, location: :living_room})
  end

  defp command_loop(%Game{done: true}) do
    {:ok, :eof}
  end

  defp command_loop(game) do
    user_input = IO.gets(:stdio, prompt()) |> String.strip

    case user_input do
      {:error, _reason} ->
        throw user_input

      :eof ->
        IO.puts("\n")
        {:ok, :eof}

      _ ->
        game = handle_user_command(game, user_input)
        command_loop(game)
    end
  end

  defp handle_user_command(game, user_input) do
    with {:ok, parsed_action} <- Adventure.Parser.parse_text(user_input),
      {game, game_output} <- Adventure.Actions.apply_action(game, parsed_action)
    do
      Enum.map(game_output, &IO.puts/1)
      game
    end
  end

  defp prompt(), do: "\nAdventure> "
end
