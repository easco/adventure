defmodule Adventure do

  alias Adventure.Parser

  #
  # Escript main routine
  #
  def main(_args) do
    {:ok, game} = Adventure.Game.start_link()

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
        tokens = Parser.tokenize_line(user_input)
        result = Parser.parse(tokens, %{})
        IO.puts("Result #{inspect result}")

        command_loop(game)
    end
  end

  defp prompt(), do: "Adventure> "
end
