class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.belongs_to :todo_list
      t.timestamps
    end
    add_index :items, :todo_list_id
  end
end
