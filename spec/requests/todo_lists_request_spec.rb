require 'spec_helper'

feature "User todo lists" do

  before { login! }

  scenario "can view only todo lists created by logged in user" do
    todo_list_1 = Factory.create(:todo_list, :name => "Logged in user todo list", :user => current_user)
    todo_list_2 = Factory.create(:todo_list, :name => "Anonymous todo list")
    visit todo_lists_path
    page.should     have_content todo_list_1.name
    page.should_not have_content todo_list_2.name
  end

  scenario "show at least #{TodoList::NUMBER_OF_EMPTY_TASK_FIELDS} text fields for tasks when creating a todo list" do
    visit new_todo_list_path
    all("div#tasks > div.task_field input[type=text]").should have(TodoList::NUMBER_OF_EMPTY_TASK_FIELDS).items
    fill_in "Name", :with => ""
    click_button "Create Todo list"
    all("div#tasks > div.task_field input[type=text]").should have(TodoList::NUMBER_OF_EMPTY_TASK_FIELDS).items
    fill_in(find(:task_field, 1)[:id], :with => "Can't find a good name to my todo list")
    click_button "Create Todo list"
    all("div#tasks > div.task_field input[type=text]").should have(TodoList::NUMBER_OF_EMPTY_TASK_FIELDS).items
  end

  scenario "can create a todo list with valid attributes" do
    visit new_todo_list_path
    fill_in "Name", :with => "Christmas wish list"
    fill_in(find(:task_field, 1)[:id], :with => "Kindle")
    click_button "Create Todo list"
    current_path.should eq todo_lists_path
    within(".flash_message")  { page.should have_content "Todo list was successfully created." }
    within("div#todo_lists")  { page.should have_content "Christmas wish list" }
    within("ul.tasks")        { page.should have_content "Kindle" }
  end

  scenario "can create a todo list adding items dinamically", :js => true do
    visit new_todo_list_path
    fill_in "Name", :with => "Things to learn"
    all("div#tasks > div.task_field").should have(4).items
    fill_in(find(:task_field, 1)[:id], :with => "Node.js")
    fill_in(find(:task_field, 2)[:id], :with => "EventMachine")
    fill_in(find(:task_field, 3)[:id], :with => "SVG")
    fill_in(find(:task_field, 4)[:id], :with => "NoSQL")
    click_link "Add task"
    all("div#tasks > div.task_field").should have(5).items
    fill_in(find(:task_field, 5)[:id], :with => "Titanium Mobile")
    click_button "Create Todo list"
    current_path.should eq todo_lists_path
    within(".flash_message") { page.should have_content "Todo list was successfully created." }
    within("div#todo_lists") { page.should have_content "Things to learn" }
    within("ul.tasks") do
      page.should have_content "Node.js"
      page.should have_content "EventMachine"
      page.should have_content "SVG"
      page.should have_content "NoSQL"
      page.should have_content "Titanium Mobile"
    end
  end

  scenario "cannot create a todo list without name" do
    visit new_todo_list_path
    fill_in "Name", :with => ""
    click_button "Create Todo list"
    within("span.error") { page.should have_content "can't be blank" }
  end

  scenario "can update a todo list", :js => true do
    todo_list = current_user.todo_lists.create(:name => "Things to learn")
    todo_list.tasks.create([{ :name => "Backbone" }, { :name => "SproutCore" }])
    visit edit_todo_list_path(todo_list)
    all("div#tasks > div.task_field").should have(2).items
    fill_in "Name", :with => "Things I MUST to learn"
    fill_in(find(:task_field, 1)[:id], :with => "Backbone.js")
    click_button "Update Todo list"
    current_path.should eq todo_lists_path
    within(".flash_message") { page.should have_content "Todo list was successfully updated." }
    within("div#todo_lists") { page.should have_content "Things I MUST to learn" }
    within("ul.tasks") do
      page.should have_content "Backbone.js"
      page.should have_content "SproutCore"
    end
  end

  scenario "can remove items from a todo list", :js => true do
    todo_list = current_user.todo_lists.create(:name => "Awesome list")
    todo_list.tasks.create([{ :name => "Cool item" }, { :name => "Not so cool" }])
    visit edit_todo_list_path(todo_list)
    find("div#tasks > div.task_field:nth-child(2) a.remove_child").click
    click_button "Update Todo list"
    all("ul.tasks").should have(1).item
    within("ul.tasks") do
      page.should have_content "Cool item"
      page.should_not have_content "Not so cool"
    end
  end

  scenario "can remove a todo list", :js => true do
    todo_list           = current_user.todo_lists.create(:name => "Awesome list")
    todo_list_to_remove = current_user.todo_lists.create(:name => "Not so cool")
    visit todo_lists_path
    page.evaluate_script('window.confirm = function() { return true; }')
    find("a#remove_todo_list_#{todo_list_to_remove.id}").click
    page.should have_selector("div#todo_list_#{todo_list.id}")
    page.should have_content(todo_list.name)
    page.should_not have_selector("div#todo_list_#{todo_list_to_remove.id}")
    page.should_not have_content(todo_list_to_remove.name)
  end

end