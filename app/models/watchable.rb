module Watchable

  def watch!(todo_list)
    if can_watch? todo_list
      watchings.create! :watched_list => todo_list
    end
  end

  def can_watch?(todo_list)
    todo_list.public? && !todo_lists.include?(todo_list)
  end

  def unwatch!(todo_list)
    if watching? todo_list
      watched_lists.destroy todo_list
    end
  end

  def watching?(todo_list)
    !!watchings.find_by_watched_list_id(todo_list)
  end

end