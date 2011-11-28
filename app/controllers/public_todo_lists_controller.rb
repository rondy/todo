class PublicTodoListsController < ApplicationController

  def index
    @public_todo_lists = TodoList.public_visibility
  end

end
