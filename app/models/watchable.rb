module Watchable

  def watch!(todo_list)
    if can_watch? todo_list
      watchings.create! :watched_list => todo_list
    end
  end

  def can_watch?(todo_list)
    todo_list.public? && !owns?(todo_list)
  end

  def owns?(todo_list)
    self.id == todo_list.user_id
  end

  def unwatch!(todo_list)
    if watching? todo_list
      watched_lists.destroy todo_list
    end
  end

  def watching?(todo_list)
    !!todo_list.watchers.include?(self)
  end

end