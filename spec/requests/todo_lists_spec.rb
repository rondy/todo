require 'spec_helper'

feature "todo lists" do

  scenario "can create a new todo list" do
    visit new_todo_list_url
    fill_in "Name", :with => "Christmas wish list"
    click_button "Create Todo list"
    current_path.should eq todo_lists_path
    within("#flash_message") { page.should have_content "Todo list created" }
    within("div#todo_lists") { page.should have_content "Christmas wish list" }
  end

end