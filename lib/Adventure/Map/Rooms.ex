defmodule Adventure.Rooms do
  import Supervisor.Spec
  alias Adventure.Entity.Room

  @rooms_array [
    %Room{
             id: :living_room,
          title: "Living Room",
    description: "You are in the living-room of a wizards house.\nThere is a wizard snoring loudly on the couch.",
          exits: [ west: {"door", :garden },
                     up: {"stairway", :attic } ]},

    %Room{
             id: :garden,
          title: "Garden",
    description: "You are in a beautiful garden. There is a well in front of you.",
          exits: [ east: {"door", :living_room } ]},

    %Room{
             id: :attic,
          title: "Attic",
    description: "You are in the attic of the wizards house.\nThere is a giant welding torch in the corner.",
          exits: [ down: {"ladder", :living_room } ]}
  ]

  def start_link() do
    children = Enum.map(@rooms_array, fn(room_map) ->
      worker(Room, [room_map], id: room_map.id)
    end)

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
