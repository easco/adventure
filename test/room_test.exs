defmodule AdventureTest.Room do
  use ExUnit.Case
  alias Adventure.Room, as: Room

  test "creating a room should work" do
    test_room = %Adventure.Room{}
    assert test_room.title == "Unknown Room"
    assert test_room.description == "A formless gray room"
    assert test_room.exits == []
  end

  test "rooms should have exits" do
    test_room = %Adventure.Room{exits: [{:west, "Path", :other_room}]}
    assert test_room.exits == [{:west, "Path", :other_room}]
  end

  test "generates title description" do
    test_room = Room.new(:test_room, %{title: "title", description: "description"})
    assert Room.titled_description(test_room) == "title\n\ndescription"
  end
end
