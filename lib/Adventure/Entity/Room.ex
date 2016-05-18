defmodule Adventure.Entity.Room do
  alias Adventure.Component.Title
  alias Adventure.Component.Description

  def start_link(id, title, description) do
    Adventure.Entity.start_link(id, [
      Title.new(title),
      Description.new(description)
    ], name: {:via, Adventure.Map, id})
  end

  def description(room) do
    {:title, title} = Title.get(room)
    {:description, description} = Description.get(room)

    "#{IO.ANSI.bright()}#{title}#{IO.ANSI.normal()}\n\n#{description}"
  end
end