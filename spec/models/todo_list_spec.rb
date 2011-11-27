require 'spec_helper'

describe TodoList do

  it "builds empty tasks (4 by default)" do
    todo_list = TodoList.new
    todo_list.tasks.should be_empty
    todo_list.build_empty_tasks
    todo_list.tasks.should have(4).tasks

    todo_list = TodoList.new
    todo_list.tasks.should be_empty
    todo_list.build_empty_tasks(2)
    todo_list.tasks.should have(2).tasks

    todo_list = TodoList.new
    todo_list.tasks.build(:name => "only one item for while")
    todo_list.build_empty_tasks
    todo_list.tasks.should have(1).item
  end

end
