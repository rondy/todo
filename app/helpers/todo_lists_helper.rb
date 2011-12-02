module TodoListsHelper

  def visibility(todo_list)
    content_tag :em, "(private)" if todo_list.private?
  end

  def setup_task_fields(todo_list)
    todo_list.new_record? ? todo_list.tasks_with_empty_items : todo_list.tasks
  end

  def render_action_links_for(todo_list)
    if current_user.owns?(todo_list)
      links_to_manage_todo_list(todo_list)
    else
      link_to_toggle_watching(todo_list)
    end
  end

  def links_to_manage_todo_list(todo_list)
    [link_to_edit_todo_list(todo_list), link_to_destroy_todo_list(todo_list)].join(" | ").html_safe
  end

  def link_to_edit_todo_list(todo_list)
    link_to "(Edit)",
            edit_todo_list_path(todo_list),
            :id     => "edit_todo_list_#{todo_list.id}",
            :class  => "edit"
  end

  def link_to_destroy_todo_list(todo_list)
    link_to "(Remove)",
            todo_list_path(todo_list),
            :method   => :delete,
            :confirm  => "Are you sure?",
            :id       => "remove_todo_list_#{todo_list.id}",
            :class    => "destroy"
  end

  def link_to_toggle_watching(todo_list)
    content_tag :span, :class => "toggle_watching" do
      if current_user.can_watch? todo_list
        if current_user.watching? todo_list
          link_to_unwatch todo_list
        else
          link_to_watch todo_list
        end
      end
    end
  end

  def link_to_unwatch(todo_list)
    link_to "Unwatch",
            watched_list_path(todo_list),
            :method => :delete,
            :id     => "unwatch_todo_list_#{todo_list.id}",
            :class  => "watching"
  end

  def link_to_watch(todo_list)
    link_to "Watch",
            watched_lists_path(:todo_list_id => todo_list),
            :method => :post,
            :id     => "watch_todo_list_#{todo_list.id}",
            :class  => "watching"
  end

end
