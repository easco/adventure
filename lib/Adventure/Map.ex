defmodule Adventure.Map do
  alias Adventure.Room
  alias Adventure.Object

  defstruct rooms: [], object_locations: %{}

  def start_link do
      Agent.start_link(fn -> Adventure.Map.new() end, name: __MODULE__ )
  end

  def known_objects() do
    Agent.get(__MODULE__, fn map -> Object.known_objects(map) end)
  end

  def new do
    rooms_array =  [
      Room.new( :living_room,
            title: "Living Room",
      description: "You are in the living-room of a wizards house. There is a wizard snoring loudly on the couch.",
            exits: [ {:west, "door", :garden },
                     {:up, "stairway", :attic} ]),

      Room.new( :garden,
            title: "Garden",
      description: "You are in a beautiful garden. There is a well in front of you.",
            exits: [{:east, "door", :living_room }]),

      Room.new( :attic,
            title: "Attic",
      description: "You are in the attic of the wizards house. There is a giant welding torch in the corner.",
            exits: [{:down, "stairway", :living_room }])
  ]

  %Adventure.Map{
    rooms: (for room <- rooms_array, do: {room.id, room}),

    object_locations: %{
      whiskey_bottle: :living_room,
      bucket: :living_room,
      chain: :garden,
      frog: :garden
    },
  }
  end

  def room(map, room_id) do
    map.rooms[room_id]
  end

  def objects_in_room(map, room) do
    map.object_locations
      |> Enum.filter(fn ({_, location}) -> location == room.id end)
      |> Enum.map(fn ({item_id, _location}) -> item_id end)
  end

  def room_description(map, room) do
    main_description = Room.titled_description(room)

    objects_description = Adventure.Map.objects_in_room(map, room)
                            |> Enum.map(&Adventure.Object.description/1)
                            |> Enum.join("\n")

    main_description <> "\n" <> objects_description
  end
end