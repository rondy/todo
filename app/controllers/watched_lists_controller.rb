class WatchedListsController < PublicTodoListsController

  def index
    @watched_lists = current_user.watched_lists.includes(:tasks, :user, :watchers)
    respond_with(@watched_lists)
  end

  def create
    @todo_list = TodoList.public_visibility.find(params[:todo_list_id])

    if current_user.watch!(@todo_list)
      flash[:notice] = %{You are watching "%s"} % @todo_list.name
    end

    redirect_to public_todo_lists_url
  end

  def destroy
    @todo_list = TodoList.public_visibility.find_by_id(params[:id])

    if current_user.unwatch!(@todo_list)
      flash[:notice] = %{You are no longer watching "%s"} % @todo_list.name
    end

    redirect_to public_todo_lists_url
  end

end
