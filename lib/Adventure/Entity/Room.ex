defmodule Adventure.Entity.Room do
  alias Adventure.Component.Title
  alias Adventure.Component.Description

  def start_link(id, title, description) do
    Adventure.Entity.start_link(id, [
      Title.new(title),
      Description.new(description)
    ])
  end
end