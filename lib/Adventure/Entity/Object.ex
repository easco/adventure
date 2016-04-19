defmodule Adventure.Entity.Object do
  alias Adventure.Entity
  alias Adventure.Component.Title
  alias Adventure.Component.Description

  def start_link(id, name, description) do
    Entity.start_link(id, [
      Title.new(name),
      Description.new(description)
    ])
  end

  def all_objects() do
    [
      %{        id: :frog,
              name: "frog",
       description: "A small green frog" },

      %{        id: :bucket,
              name: "bucket",
       description: "A sturdy metal bucket" },

      %{        id: :whiskey_bottle,
              name: "bottle",
       description: "A half-empty bottle of quality whiskey" },

      %{        id: :chain,
              name: "chain",
        escription: "A long, but light length of chain" }
    ]
  end
end

