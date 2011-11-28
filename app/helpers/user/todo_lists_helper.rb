module User::TodoListsHelper

  def visibility(todo_list)
    content_tag :em, "(private)" if todo_list.private?
  end

end
