defmodule Adventure.Component.Description do
  use Adventure.Component, id: :description
  alias Adventure.Entity

  def new(textDescription) do
    { id(), textDescription }
  end

  def get_description(entity) do
    Entity.get_component(entity, id())
  end
end