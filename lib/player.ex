defmodule Adventure.Player do
  defstruct inventory: MapSet.new()

  def new(), do: %__MODULE__{}

  def has_item?(player, item), do: Enum.member?(player.inventory, item)

  def pick_up(player, item),
    do: %__MODULE__{player | inventory: MapSet.put(player.inventory, item)}

  def drop(player, item),
    do: %__MODULE__{player | inventory: MapSet.delete(player.inventory, item)}
end
