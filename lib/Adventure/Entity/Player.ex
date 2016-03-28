defmodule Adventure.Entity.Player do
    alias Adventure.Component.Description

    def start_link() do
      Adventure.Entity.start_link([
          Description.new("This is You. You look good.")
        ])
    end
end