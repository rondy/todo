require 'spec_helper'

describe TodoList do

  it "builds empty tasks (#{TodoList::NUMBER_OF_TASK_FIELDS} by default)" do
    todo_list = TodoList.new
    todo_list.tasks_with_empty_items.should have(TodoList::NUMBER_OF_TASK_FIELDS).items

    todo_list = TodoList.new
    todo_list.tasks.build(:name => "Just one item for while")
    todo_list.tasks_with_empty_items.should have(TodoList::NUMBER_OF_TASK_FIELDS).items

    todo_list = TodoList.new
    10.times { |n| todo_list.tasks.build(:name => "Task #{n}") }
    todo_list.tasks_with_empty_items.should have(10).items
  end

end
