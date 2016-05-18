defmodule Adventure.MapSupervisor do
  import Supervisor.Spec
  alias  Adventure.Entity.Room

  def start_link() do
    children = [
      worker(Adventure.Map, []),
      supervisor(Adventure.Rooms, [], restart: :permanent)
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end