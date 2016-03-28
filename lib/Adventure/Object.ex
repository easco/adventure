defmodule Adventure.Object do
  defstruct object_id: :unknown,  name: ["blob"], description: "A formless grey blob"

  def all_objects() do
    alias Adventure.Object
    [
      %Object{ object_id: :frog,
                    name: "frog",
             description: "A small green frog" },

      %Object{ object_id: :bucket,
                    name: "bucket",
             description: "A sturdy metal bucket" },

      %Object{ object_id: :whiskey_bottle,
                    name: "bottle",
             description: "A half-empty bottle of quality whiskey" },

      %Object{ object_id: :chain,
                    name: "chain",
             description: "A long, but light length of chain" }
    ]
  end

  def with_id(object_id) do
     Enum.find(all_objects, fn(object) -> object.object_id == object_id end)
  end

  def name(object_id) do
    __MODULE__.with_id(object_id).name
  end

  def description(object_id) do
    __MODULE__.with_id(object_id).description
  end
end

