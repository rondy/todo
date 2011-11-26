class TodoListsController < ApplicationController

  def index
    @todo_lists = TodoList.all
  end

  def new
    @todo_list = TodoList.new
    4.times { @todo_list.items.build }
  end

  def create
    @todo_list = TodoList.new(params[:todo_list])
    if @todo_list.save
      redirect_to todo_lists_url, :notice => "Todo list created"
    else
      render "new"
    end
  end

end
