class TodoListsController < ApplicationController

  def index
    @todo_lists = TodoList.all
  end

  def new
    @todo_list = TodoList.new
  end

  def create
    @todo_list = TodoList.create!(params[:todo_list])
    redirect_to todo_lists_url, :notice => "Todo list created"
  end

end
