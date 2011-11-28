class TodoList < ActiveRecord::Base

  has_many :tasks
  belongs_to :user
  has_many :watchings, :foreign_key => "watched_list_id", :dependent => :destroy
  has_many :watchers, :through => :watchings, :source => :watcher

  validates :name, :presence => true
  accepts_nested_attributes_for :tasks, :reject_if => lambda { |task| task["name"].blank? }, :allow_destroy  => true

  scope :public_visibility, where(:private => false)

  def build_empty_tasks(n=4)
    n.times { tasks.build } if tasks.empty?
  end

  def public?
    !private?
  end

end
