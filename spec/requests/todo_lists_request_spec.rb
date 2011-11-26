require 'spec_helper'

feature "Todo lists" do

  scenario "can create a todo list with valid attributes" do
    visit new_todo_list_url
    fill_in "Name", :with => "Christmas wish list"
    within("#todo_list_items") do
      fill_in "todo_list_items_attributes_0_name", :with => "Kindle"
      fill_in "todo_list_items_attributes_1_name", :with => "Coldplay - Mylo Xyloto"
    end
    click_button "Create Todo list"
    current_path.should eq todo_lists_path
    within("#flash_message") { page.should have_content "Todo list created" }
    within("div#todo_lists") { page.should have_content "Christmas wish list" }
    within("ul.todo_list_items") do
      page.should have_content "Kindle"
      page.should have_content "Coldplay - Mylo Xyloto"
    end
  end

  scenario "cannot create a todo list without name" do
    visit new_todo_list_url
    fill_in "Name", :with => ""
    click_button "Create Todo list"
    within("#error_explanation") { page.should have_content "Name can't be blank" }
  end

end