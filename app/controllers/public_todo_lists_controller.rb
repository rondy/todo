class PublicTodoListsController < ApplicationController

  def index
    @public_todo_lists = TodoList.all
  end

end
