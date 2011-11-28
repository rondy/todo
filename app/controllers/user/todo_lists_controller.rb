class User::TodoListsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @todo_lists = current_user.todo_lists.all
  end

  def new
    @todo_list = current_user.todo_lists.build
    @todo_list.build_empty_tasks
  end

  def create
    @todo_list = current_user.todo_lists.build(params[:todo_list])
    if @todo_list.save
      redirect_to user_todo_lists_url, :notice => "Todo list created"
    else
      @todo_list.build_empty_tasks
      render "new"
    end
  end

  def edit
    @todo_list = current_user.todo_lists.find(params[:id])
  end

  def update
    @todo_list = current_user.todo_lists.find(params[:id])
    if @todo_list.update_attributes(params[:todo_list])
      redirect_to user_todo_lists_url, :notice => "Todo list updated"
    else
      render "edit"
    end
  end

end