class TodoListsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @todo_lists = current_user.todo_lists.includes(:tasks, :user)
    respond_with(@todo_lists)
  end

  def new
    @todo_list = current_user.todo_lists.build
    respond_with(@todo_lists)
  end

  def create
    @todo_list = current_user.todo_lists.create(params[:todo_list])
    respond_with(@todo_list)
  end

  def edit
    @todo_list = current_user.todo_lists.find(params[:id])
    respond_with(@todo_list)
  end

  def update
    @todo_list = current_user.todo_lists.find(params[:id])
    @todo_list.update_attributes(params[:todo_list])
    respond_with(@todo_list)
  end

  def destroy
    @todo_list = current_user.todo_lists.find(params[:id])
    @todo_list.destroy
    respond_with(@todo_list)
  end

end
