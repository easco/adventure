defmodule Adventure.Component do
  defmacro __using__([id: identifier]) do
  	quote do
	    def id(), do: unquote identifier
  	end
  end

  defmacro __using__(_) do
  	quote do
    	def id(), do: unquote __MODULE__
    end
  end
end