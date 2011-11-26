require 'spec_helper'

feature "Todo lists" do

  scenario "can create a todo list with valid attributes" do
    visit new_todo_list_path

    fill_in "Name", :with => "Christmas wish list"
    within("#todo_list_items") { fill_in "todo_list_items_attributes_0_name", :with => "Kindle" }
    click_button "Create Todo list"

    current_path.should eq todo_lists_path

    within("#flash_message") { page.should have_content "Todo list created" }
    within("div#todo_lists") { page.should have_content "Christmas wish list" }
    within("ul.todo_list_items") { page.should have_content "Kindle" }
  end

  scenario "can create a todo list adding items dinamically", :js => true do
    visit new_todo_list_path
    fill_in "Name", :with => "Things to learn"
    click_link "Add item"
    all("#todo_list_items > .todo_list_item").should have(2).items
    fill_in(find("div#todo_list_items > div.todo_list_item:nth-child(1) input")[:id], :with => "Node.js")
    fill_in(find("div#todo_list_items > div.todo_list_item:nth-child(2) input")[:id], :with => "NoSQL")
    click_button "Create Todo list"
    current_path.should eq todo_lists_path
    within("#flash_message") { page.should have_content "Todo list created" }
    within("div#todo_lists") { page.should have_content "Things to learn" }
    within("ul.todo_list_items") { page.should have_content "Node.js" }
    within("ul.todo_list_items") { page.should have_content "NoSQL" }
  end

  scenario "cannot create a todo list without name" do
    visit new_todo_list_path
    fill_in "Name", :with => ""
    click_button "Create Todo list"
    within("#error_explanation") { page.should have_content "Name can't be blank" }
  end

end