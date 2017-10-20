defmodule Adventure.Parser do
  alias Adventure.Game

  defmodule Result do
    defstruct action: :none, object: nil
  end

  def parse_text(user_input) do
    action_map =
      user_input
      |> tokenize_line
      |> parse(%{})

    {:ok, action_map}
  end

  def tokenize_line(line) do
    line
    |> String.split(" ")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&String.downcase(&1))
    |> Enum.map(fn word -> String.replace(word, ~r/[^a-z]/, "") end)
    |> Enum.map(&classify_word/1)
  end

  def parse([], %{direction: _} = result) when 1 == map_size(result) do
    Map.put(result, :action, :go)
  end

  def parse([], result) do
    result
  end

  def parse([{:verb, action} | rest], result) do
    parse(rest, Map.put(result, :action, action))
  end

  def parse([{:noun, what} | rest], result) do
    parse(rest, Map.put(result, :object, what))
  end

  def parse([{:article, _}, {:noun, what} | rest], result) do
    parse([noun: what] ++ rest, result)
  end

  def parse([{:direction, direction} | rest], result) do
    parse(rest, Map.put(result, :direction, direction))
  end

  def parse([{:command, command} | rest], result) do
    parse(rest, Map.put(result, :action, command))
  end

  def parse([head | rest], result) do
    if Map.has_key?(result, :unknowns) do
      parse(rest, Map.put(result, :unknowns, result.unknowns ++ [head]))
    else
      parse(rest, Map.put(result, :unknowns, [head]))
    end
  end

  # Use metaprogramming to define the classify_word function

  @verbs [
    {"get", :take},
    {"take", :take},
    {"drop", :drop},
    {"release", :drop},
    {"kill", :destroy},
    {"go", :go},
    {"look", :look},
    {"examine", :look}
  ]

  @articles [
    {"the", :definate},
    {"a", :indefinite},
    {"an", :indefinite}
  ]

  @movements [
    {"north", :north},
    {"south", :south},
    {"east", :east},
    {"west", :west},
    {"up", :up},
    {"down", :down},
    {"climb", :up},
    {"descend", :down},
    {"n", :north},
    {"s", :south},
    {"e", :east},
    {"w", :west},
    {"u", :up},
    {"d", :down}
  ]

  @commands [
    {"quit", :quit},
    {"q", :quit}
  ]

  # pull in all the known verbs and set up classify_word to define them as verbs
  # with the corresponding actions assoicated with them
  for {verb, action} <- @verbs do
    def classify_word(unquote(verb)) do
      {:verb, unquote(action)}
    end
  end

  # pull in all the known objects and set up classify_word to identify them as nouns
  for %{id: object_id, name: name} <- Game.all_objects() do
    def classify_word(unquote(name)) do
      {:noun, unquote(object_id)}
    end
  end

  # set up classify_word for the articles
  for {article, type} <- @articles do
    def classify_word(unquote(article)) do
      {:article, unquote(type)}
    end
  end

  # set up classify_word for the movements
  for {command, direction} <- @movements do
    def classify_word(unquote(command)) do
      {:direction, unquote(direction)}
    end
  end

  for {word, command} <- @commands do
    def classify_word(unquote(word)) do
      {:command, unquote(command)}
    end
  end

  def classify_word(word) do
    {:unknown, word}
  end
end
