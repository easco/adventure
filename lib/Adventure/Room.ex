defmodule Adventure.Room do
  defstruct id: :unknown_room, title: "Unknown Room", description: "A formless gray room", exits: []

  def new(room_id, options) do
     Map.merge(%Adventure.Room{id: room_id}, Enum.into(options, %{}))
  end

  def titled_description(room) do
    room.title <> "\n\n" <> room.description
  end
end