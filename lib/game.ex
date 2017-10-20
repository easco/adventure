defmodule Adventure.Game do
  alias Adventure.Object
  alias Adventure.World

  defstruct done: false, location: :living_room, world: nil

  def new(), do: %__MODULE__{world: World.new()}

  def all_objects() do
    [
      %Object{id: :frog, name: "frog", description: "A small green frog"},
      %Object{id: :bucket, name: "bucket", description: "A sturdy metal bucket"},
      %Object{
        id: :whiskey_bottle,
        name: "bottle",
        description: "A half-empty bottle of quality whiskey"
      },
      %Object{id: :chain, name: "chain", description: "A long, but light length of chain"},
      %Object{
        id: :wizard,
        name: "wizard",
        description: "The wizard is asleep and cannot be woken"
      }
    ]
  end
end
