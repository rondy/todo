class PublicTodoListsController < TodoListsController

  def index
    @public_todo_lists = TodoList.public_visibility.except_for_user(current_user)
    respond_with(@public_todo_lists)
  end

end
