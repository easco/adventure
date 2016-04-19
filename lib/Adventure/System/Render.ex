defmodule Adventure.System.Render do
  def render(entity) do
    components = Adventure.Entity.components(entity)
    render_components(components)
  end

  def render_components(%{title: title, description: description}) do
    IO.puts("#{title}\n\n#{description}")
  end

  def render_components(%{description: description}) do
    IO.puts("#{description}")
  end

  def render_components(_) do
  end
end
