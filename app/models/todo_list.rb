class TodoList < ActiveRecord::Base

  has_many :tasks
  belongs_to :user
  has_many :watchings, :foreign_key => "watched_list_id", :dependent => :destroy
  has_many :watchers, :through => :watchings, :source => :watcher

  default_scope order("created_at DESC")

  validates :name, :presence => true
  accepts_nested_attributes_for :tasks, :reject_if => lambda { |task| task["name"].blank? }, :allow_destroy  => true

  scope :public_visibility, where(:private => false)
  scope :except_for_user, lambda { |user| where("user_id <> ?", user) }

  NUMBER_OF_TASK_FIELDS = 4

  def tasks_with_empty_items
    (NUMBER_OF_TASK_FIELDS - tasks.size).times { tasks.build }
    tasks
  end

  def public?
    !private?
  end

end