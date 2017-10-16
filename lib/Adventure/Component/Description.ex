defmodule Adventure.Component.Description do
  use Adventure.Component, id: :description
  alias Adventure.Entity

  def new(textDescription), do: {id(), textDescription}
  def get(entity), do: Entity.get_component(entity, id())
end
