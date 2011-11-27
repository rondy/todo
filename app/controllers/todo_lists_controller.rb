class TodoListsController < ApplicationController

  def index
    @todo_lists = TodoList.all
  end

  def new
    @todo_list = TodoList.new
    @todo_list.build_empty_items
  end

  def create
    @todo_list = TodoList.new(params[:todo_list])
    if @todo_list.save
      redirect_to todo_lists_url, :notice => "Todo list created"
    else
      @todo_list.build_empty_items
      render "new"
    end
  end

  def edit
    @todo_list = TodoList.find(params[:id])
  end

  def update
    @todo_list = TodoList.find(params[:id])
    if @todo_list.update_attributes(params[:todo_list])
      redirect_to todo_lists_url, :notice => "Todo list updated"
    else
      render "edit"
    end
  end

end
