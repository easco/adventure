defmodule Adventure.Component.Title do
  use Adventure.Component, id: :title
  alias Adventure.Entity

  def new(title), do: {id(), title}
  def get(entity), do: Entity.get_component(entity, id())
end
