module TodoListsHelper

  def visibility(todo_list)
    content_tag :em, "(private)" if todo_list.private?
  end

  def setup_task_fields(todo_list)
    todo_list.new_record? ? todo_list.tasks_with_empty_items : todo_list.tasks
  end

end
