defmodule Adventure.Entity.Player do
  alias Adventure.Entity
  alias Adventure.Component.Description
  alias Adventure.Component.Location
  alias Adventure.Component.Inventory

  def start_link() do
    Adventure.Entity.start_link(:player, [
      Description.new("This is You. You look good."),
      Location.new(:living_room),
      Inventory.new()
    ])
  end

  def move_to(player, new_room_id) do
    Entity.put_component(player, Location.new(new_room_id))
  end
 end