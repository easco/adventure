defmodule AdventureTest.Object do
  use ExUnit.Case

  test "extracts from map" do
    adventure_map = Adventure.Map.new()
    objects = Adventure.Object.known_objects(adventure_map)
  end
end