defmodule Adventure.Room do
  @enforce_keys [:id, :title, :description, :items, :exits]
  defstruct [:id, :title, :description, :exits, items: MapSet.new()]

  def remove_item(room, item), do: %__MODULE__{room | items: MapSet.delete(room.items, item)}
  def add_item(room, item), do: %__MODULE__{room | items: MapSet.put(room.items, item)}

  def contains_item?(room, item), do: Enum.member?(room.items, item)
end
