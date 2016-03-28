defmodule AdventureTest.Map do
  use ExUnit.Case
  alias Adventure.Map, as: Map

  test "Creating a simple Map" do
    map = Map.new()

    rooms = map.rooms
    assert Enum.count(rooms) == 3
  end

  test "Extracting a room by id" do
    map = Map.new()

    living_room = Map.room(map, :living_room)
    assert nil != living_room
  end
end
