defmodule Adventure.World do
  alias Adventure.Room

  @moduledoc """
  The World holds the state for locations within the game
  """

  @doc """
  Constructs a new map with the set of initial rooms and conditions
  """
  def new() do
    Enum.into(initial_rooms(), %{}, &{&1.id, &1})
  end

  @doc "Return the room from the map with the given ID."
  def get_room(world, room_id) do
    Map.get(world, room_id, :none)
  end

  defp initial_rooms() do
    [
      %Room{
        id: :living_room,
        title: "Living Room",
        description:
          "You are in the living-room of a wizard's house.\nThere is a wizard snoring loudly on the couch.",
        items: room_items([:whiskey_bottle, :bucket]),
        exits: [west: {"door", :garden}, up: {"stairway", :attic}]
      },
      %Room{
        id: :garden,
        title: "Garden",
        description: "You are in a beautiful garden. There is a well at its center.",
        items: room_items([:chain, :frog]),
        exits: [east: {"door", :living_room}]
      },
      %Room{
        id: :attic,
        title: "Attic",
        description:
          "You are in the attic of the wizard's house.\nThere is a giant welding torch in the corner.",
        items: room_items([]),
        exits: [down: {"ladder", :living_room}]
      }
    ]
  end

  defp room_items([_ | _] = items), do: Enum.into(items, MapSet.new())
  defp room_items([]), do: MapSet.new()
end
