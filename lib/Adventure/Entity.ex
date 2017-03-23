defmodule Adventure.Entity do
	def start_link(id, components, opts \\ []) when is_atom(id) do
		# Start the entity's server
		{:ok, new_entity} =  GenServer.start_link(__MODULE__, id, opts)

		# Add all the components
		Enum.each(components, fn(component) -> update_component(new_entity, elem(component, 0), just_put(elem(component,1))) end)

		{:ok, new_entity}
	end

	# Returns a component update function that just replaces the component value with a new value
	defp just_put(new_value), do: fn(_ignore_value) -> new_value end

	def id(entity) do
	  GenServer.call(entity, :get_id)
	end

	def components(entity) do
		GenServer.call(entity, :get_components)
	end

	def get_component(entity, component_id) when is_atom(component_id) do
		GenServer.call(entity, {:get_component, component_id})
	end

	def update_component(entity, component_id, update_function) when is_atom(component_id) do
		GenServer.call(entity, {:update_component, component_id, update_function})
	end

	# callbacks
	def init(entity_id) do
		{:ok, {entity_id, %{}} }
	end

	def handle_call(:get_id, _from, state = {id, _})  do
		{:reply, id, state}
	end

	def handle_call(:get_components, _from, state = {_, components}) do
		{:reply, components, state}
	end

	def handle_call({:get_component, component_id}, _from, state = {_, components}) do
		get_reply(component_id, Map.get(components, component_id), state)
	end

	def handle_call({:update_component, component_id, update_function}, _from, {entity_id, components}) do
			new_component = update_function.(Map.get(components, component_id))
			{:reply, {component_id, new_component}, {entity_id, Map.put(components, component_id, new_component)}}
	end

	# if the component couldn't be found in the list, reply nil
	defp get_reply(_component_id, nil, state), do: {:reply, nil, state}

	# if the component was found in th e list, return a tuple of the id and the component's value
	defp get_reply(component_id, component_value, state), do: {:reply, {component_id, component_value}, state}
end