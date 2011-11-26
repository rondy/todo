require 'spec_helper'

feature "Todo lists" do

  scenario "can create a todo list with valid attributes" do
    visit new_todo_list_url
    fill_in "Name", :with => "Christmas wish list"
    click_button "Create Todo list"
    current_path.should eq todo_lists_path
    within("#flash_message") { page.should have_content "Todo list created" }
    within("div#todo_lists") { page.should have_content "Christmas wish list" }
  end

  scenario "cannot create a todo list without name" do
    visit new_todo_list_url
    fill_in "Name", :with => ""
    click_button "Create Todo list"
    within("#error_explanation") { page.should have_content "Name can't be blank" }
  end

end