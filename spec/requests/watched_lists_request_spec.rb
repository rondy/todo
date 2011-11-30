require 'spec_helper'

feature "Watched todo lists" do

  before { login! }

  scenario "show link to watch only for public todo lists created by other users" do
    public_todo_list_created_by_current_user = Factory.create(:public_todo_list, :name => "The coolest list I ever made", :user => current_user)
    public_todo_list_created_by_other_user = Factory.create(:public_todo_list, :name => "The coolest list someone else ever made")
    visit public_todo_lists_path
    page.should     have_selector("a#watch_todo_list_#{public_todo_list_created_by_other_user.id}")
    page.should_not have_selector("a#watch_todo_list_#{public_todo_list_created_by_current_user.id}")
  end

  scenario "can watch a public todo list created by other user" do
    public_todo_list = Factory.create(:public_todo_list, :name => "The coolest list someone ever made")
    visit public_todo_lists_path
    find("a#watch_todo_list_#{public_todo_list.id}").click
    find("#flash_message").should have_content %{You are watching "%s"} % public_todo_list.name
  end

  scenario "can unwatch a watched todo list" do
    watched_todo_list = Factory.create(:public_todo_list, :name => "The coolest list someone ever made")
    current_user.watch! watched_todo_list
    visit watched_lists_path
    find("a#unwatch_todo_list_#{watched_todo_list.id}").click
    find("#flash_message").should have_content %{You are no longer watching "%s"} % watched_todo_list.name
  end

end