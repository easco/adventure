defmodule Adventure.Component.Inventory do
  use Adventure.Component, id: :inventory

  def new() do
      {id(), []}
  end

  def get(entity) do
    Entity.get_component(entity, id())
  end

  def add_item({id, item_list}, new_item) do
    {id, [new_item | item_list]}
  end

  def remove_item({id, item_list}, item_to_remove) do
    {id, Enum.filter(item_list, fn(element) -> element != item_to_remove end)}
  end
end