defmodule Adventure.Entity.Room do
  alias Adventure.Component.Title
  alias Adventure.Component.Description
  alias Adventure.Component.Exits

  defstruct id: :nowhere,
            title: "In The Ether",
            description: "You are in a formless gray space.\nThe silence is deafening",
            exits: []

  def start_link(room_struct) do
    Adventure.Entity.start_link(
      room_struct.id,
      [
        Title.new(room_struct.title),
        Description.new(room_struct.description),
        Exits.new(room_struct.exits)
      ],
      name: {:via, Adventure.Map, room_struct.id}
    )
  end
end
