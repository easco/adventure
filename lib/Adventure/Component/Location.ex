defmodule Adventure.Component.Location do
  use Adventure.Component, id: :location

  alias Adventure.Entity

  def new(room_id) when is_atom(room_id), do: {id(), room_id}
  def get(entity), do: Entity.get_component(entity, id())

  def which_room(entity) do
    location_id = id()
    {^location_id, room_id} =  get(entity)
    room_id
  end
end
