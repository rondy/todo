class AddPrivateToTodoLists < ActiveRecord::Migration
  def change
    add_column :todo_lists, :private, :boolean, :default => false
  end
end