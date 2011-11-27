class TodoListBelongsToUser < ActiveRecord::Migration
  def up
    change_table :todo_lists do |t|
      t.belongs_to :user
    end
    add_index :todo_lists, :user_id
  end

  def down
    change_table :todo_lists do |t|
      t.remove_belongs_to :user
    end
  end
end