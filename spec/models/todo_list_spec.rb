require 'spec_helper'

describe TodoList do

  it "builds empty items (4 by default)" do
    todo_list = TodoList.new
    todo_list.items.should be_empty
    todo_list.build_empty_items
    todo_list.items.should have(4).items

    todo_list = TodoList.new
    todo_list.items.should be_empty
    todo_list.build_empty_items(2)
    todo_list.items.should have(2).items

    todo_list = TodoList.new
    todo_list.items.build(:name => "only one item for while")
    todo_list.build_empty_items
    todo_list.items.should have(1).item
  end

end
