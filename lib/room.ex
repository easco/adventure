defmodule Adventure.Room do
  @enforce_keys [:id, :title, :description, :exits]
  defstruct [:id, :title, :description, :exits]
end
