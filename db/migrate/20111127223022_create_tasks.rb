class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.belongs_to :todo_list
      t.timestamps
    end
    add_index :tasks, :todo_list_id
  end
end
