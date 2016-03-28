defmodule Adventure.Entity do
	def start_link(components) do
		{:ok, new_entity} = Agent.start_link( fn -> %{} end )
		Enum.each(components, fn(component) -> put_component(new_entity, component) end)
		{:ok, new_entity}
	end

	def components(entity) do
		Agent.get(entity, fn (components) -> components end)
	end

	def get_component(entity, component_id) when is_atom(component_id) do
		Map.get(components(entity), component_id)
	end

	def put_component(entity, {component_id, component_data}) do
		Agent.update(entity, fn(components) -> Map.put(components, component_id, component_data) end)
	end
end