module User::WatchedListsHelper

  def link_to_watch(todo_list)
    if current_user.can_watch?(todo_list) && !current_user.watching?(todo_list)
      link_to "Watch", user_watched_lists_path(:todo_list_id => todo_list), :method => :post
    end
  end

end
