class PublicTodoListsController < TodoListsController

  def index
    @public_todo_lists = TodoList.public_visibility
    respond_with(@public_todo_lists)
  end

end
