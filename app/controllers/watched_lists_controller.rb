class WatchedListsController < ApplicationController

  def create
    @todo_list = TodoList.public_visibility.find_by_id(params[:todo_list_id])

    if @todo_list && current_user.watch!(@todo_list)
      flash[:notice] = %{You are watching %s} % @todo_list.name
    else
      flash[:error] = %{Sorry, You can't watch %s} % @todo_list.name
    end

    redirect_to public_todo_lists_url
  end

end
