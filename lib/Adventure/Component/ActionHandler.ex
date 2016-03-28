defmodule Adventure.Component.ActionHandler do
  use Adventure.Component, id: :action_handler

  def new() do
    {id(), %{ handler: fn() -> {:ok, ""} end }}
  end
end