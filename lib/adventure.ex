defmodule Adventure do

  alias Adventure.Game
  alias Adventure.CommandProcessor

  #
  # Escript main routine
  #
  def main(_args) do
    {:ok, game} = Game.start_link()
    {:ok, command_processor} = CommandProcessor.start_link(game)

    IO.puts("Welcome to Adventure! #{inspect game}\n")

    command_loop(command_processor)
  end

  defp command_loop(command_processor) do
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
        CommandProcessor.process_command(user_input)
        command_loop(command_processor)
    end
  end

  defp prompt(), do: "Adventure> "
end
