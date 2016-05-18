defmodule Adventure.Entity do

	def start_link(id, components, opts \\ []) when is_atom(id) do
		# Start the entity's server
		{:ok, new_entity} =  GenServer.start_link(__MODULE__, id, opts)

		# Add all the components
		Enum.each(components, fn(component) -> put_component(new_entity, component) end)

		# add this entity to the list of entities
		add_to_entities_list(new_entity)

		{:ok, new_entity}
	end

	def id(entity) do
	  GenServer.call(entity, :get_id)
	end

	def components(entity) do
		GenServer.call(entity, :get_components)
	end

	def get_component(entity, component_id) when is_atom(component_id) do
		GenServer.call(entity, {:get_component, component_id})
	end

	def put_component(entity, {component_id, component_data}) when is_atom(component_id) do
		GenServer.cast(entity, {:put_component, {component_id, component_data}})
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
		if Map.has_key?(components, component_id)  do
			{:reply, { component_id, Map.get(components, component_id) }, state }
		else
			{:reply, nil, state }
		end
	end

	def handle_cast({:put_component, {component_id, component_data}}, {entity_id, components}) do
		{:noreply, {entity_id, Map.put(components, component_id, component_data)}}
	end

	def handle_cast(_, state) do
		{:noreply, state}
	end

  # entities list

	def all_entities()  do
		process_list = entities_process()
		Agent.get(process_list, &(&1))
	end

	def entity_with_id(id) do
		Enum.find(all_entities(), fn(entity) -> id == id(entity) end )
	end

	defp add_to_entities_list(entity) do
		process_list = entities_process
		Agent.update(process_list, fn(entities) -> [entity | entities] end)
	end

	defp entities_process() do
		process_list = Process.whereis(__MODULE__)

		if nil == process_list do
			{:ok, process_list} = Agent.start_link( fn -> [] end, name: __MODULE__ )
		end

		process_list
	end
end