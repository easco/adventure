defmodule Adventure.Component.ActionHandler do
  use Adventure.Component, id: :action_handler

  # An action handler is a function of the form handler(entity, parsed_command) (handler/2)
  # where entity is the entity handling the command and parsed_command is the
  # result of parsing the user's command line
  def new(action_handler) do
    { id(), action_handler }
  end

  def handle_parsed_command(entity, parsed_command) do
    action_handler = Adventure.Entity.get_component(entity, id())
    if(nil != action_handler) do
      action_handler.(parsed_command)
    else
      nil
    end
  end
end