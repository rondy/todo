class TodoList < ActiveRecord::Base

  validates :name, :presence => true
  has_many :items
  accepts_nested_attributes_for :items, :reject_if => lambda { |item| item["name"].blank? }, :allow_destroy  => true

  def build_empty_items(n=4)
    n.times { items.build } if items.empty?
  end

end
