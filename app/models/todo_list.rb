class TodoList < ActiveRecord::Base

  validates :name, :presence => true

end
