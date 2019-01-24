defmodule Adventure.Item do
  alias Adventure.Item

  defstruct [:id, :article, :name, :description]

  def get_item(object_id) do
    Enum.find(all_items(), &(&1.id == object_id))
  end

  def get_name(object_id, _with_article = true) do
    object = get_item(object_id)
    "#{object.article} #{object.name}"
  end

  def get_name(object_id, _with_article = false) do
    object_id
    |> get_item()
    |> Map.get(:name)
  end

  def all_items() do
    [
      %Item{id: :frog, article: "a", name: "frog", description: "A small green frog"},
      %Item{id: :bucket, article: "a", name: "bucket", description: "A sturdy metal bucket"},
      %Item{
        id: :whiskey_bottle,
        article: "a",
        name: "bottle",
        description: "A half-empty bottle of quality whiskey"
      },
      %Item{id: :chain, name: "chain", description: "A long, but light length of chain"},
      %Item{
        id: :wizard,
        article: "a",
        name: "wizard",
        description: "The wizard is asleep and cannot be woken"
      },
      %Item{
        id: :welded_bucket,
        article: "a",
        name: "bucket welded to chain",
        description: "A bucket welded to a length of chain"
      }
    ]
  end
end
