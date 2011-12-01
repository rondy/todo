class TodoListsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @todo_lists = current_user.todo_lists.all
  end

  def new
    @todo_list = current_user.todo_lists.build
  end

  def create
    @todo_list = current_user.todo_lists.build(params[:todo_list])
    if @todo_list.save
      redirect_to todo_lists_url, :notice => "Todo list created"
    else
      render "new"
    end
  end

  def edit
    @todo_list = current_user.todo_lists.find(params[:id])
  end

  def update
    @todo_list = current_user.todo_lists.find(params[:id])
    if @todo_list.update_attributes(params[:todo_list])
      redirect_to todo_lists_url, :notice => "Todo list updated"
    else
      render "edit"
    end
  end

end
