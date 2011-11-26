class TodoList < ActiveRecord::Base

  validates :name, :presence => true
  has_many :items
  accepts_nested_attributes_for :items, :reject_if => lambda { |a| a.values.all?(&:blank?) }, :allow_destroy  => true

end
