module WatchedListsHelper

  def toggle_watching(todo_list)
    if current_user.can_watch? todo_list
      if current_user.watching? todo_list
        link_to_unwatch todo_list
      else
        link_to_watch todo_list
      end
    end
  end

  def link_to_unwatch(todo_list)
    link_to "Unwatch", watched_list_path(todo_list), :method => :delete
  end

  def link_to_watch(todo_list)
    link_to "Watch", watched_lists_path(:todo_list_id => todo_list), :method => :post
  end

end
