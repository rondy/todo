class TodoList < ActiveRecord::Base

  validates :name, :presence => true
  has_many :tasks
  belongs_to :user
  accepts_nested_attributes_for :tasks, :reject_if => lambda { |task| task["name"].blank? }, :allow_destroy  => true

  def build_empty_tasks(n=4)
    n.times { tasks.build } if tasks.empty?
  end

end
