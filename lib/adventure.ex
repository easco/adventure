defmodule Adventure do

  alias Adventure.Game
  alias Adventure.CommandProcessor

  #
  # Escript main routine
  #
  def main(_args) do
    {:ok, game} = Game.start_link()

    IO.puts("Welcome to Adventure! #{inspect game}\n")

    command_loop(game)
  end

  defp command_loop(game) do
    user_input = IO.gets(:stdio, prompt())

    case user_input do
      {:error, _reason} ->
        throw user_input

      :eof ->
        IO.puts("\n")
        {:ok, :eof}

      "quit\n" ->
        {:ok, :eof}

      _ ->
        CommandProcessor.process_command(game, user_input)
        command_loop(game)
    end
  end

  defp prompt(), do: "Adventure> "
end
