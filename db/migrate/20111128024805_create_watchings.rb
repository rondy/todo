class CreateWatchings < ActiveRecord::Migration
  def change
    create_table :watchings do |t|
      t.belongs_to :watcher
      t.belongs_to :watched_list
      t.timestamps
    end
    add_index :watchings, :watcher_id
    add_index :watchings, :watched_list_id
  end
end
