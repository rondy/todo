class Watching < ActiveRecord::Base

  belongs_to :watcher,      :class_name => "User"
  belongs_to :watched_list, :class_name => "TodoList", :conditions => { :private => false }

end
