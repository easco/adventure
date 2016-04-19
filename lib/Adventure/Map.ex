defmodule Adventure.Map do
  import Supervisor.Spec
  alias  Adventure.Entity.Room

  @rooms_array [
    %{       id: :living_room,
          title: "Living Room",
    description: "You are in the living-room of a wizards house. There is a wizard snoring loudly on the couch.",
          exits: [ {:west, "door", :garden },
                   {:up, "stairway", :attic} ]},

    %{       id: :garden,
          title: "Garden",
    description: "You are in a beautiful garden. There is a well in front of you.",
          exits: [{:east, "door", :living_room }]},

    %{       id: :attic,
          title: "Attic",
    description: "You are in the attic of the wizards house. There is a giant welding torch in the corner.",
          exits: [{:down, "stairway", :living_room }]}
  ]

  def start_link() do
    children = Enum.map(@rooms_array, fn(room_map) ->
      worker(Room, [room_map.id, room_map.title, room_map.description], id: room_map.id)
    end)

    Supervisor.start_link(children, strategy: :one_for_one)
  end

  def room(map, room_id), do: child_by_id(map, room_id)

  defp child_by_id(supervisor, which_child_id) do
    case Enum.find(Supervisor.which_children(supervisor), fn({child_id, _, _, _}) -> child_id == which_child_id end ) do
      {_, child_pid, _, _} -> child_pid
      _ -> nil
    end
  end
end