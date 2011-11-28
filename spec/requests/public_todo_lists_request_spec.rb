require 'spec_helper'

feature "Public todo lists" do

  before { login! }

  scenario "shows only public todo lists (not marked as private)" do
    public_todo_list  = Factory(:todo_list, :name => "Everyone wants to see me", :private => false)
    private_todo_list = Factory(:todo_list, :name => "Top secret", :private => true)
    visit public_todo_lists_path
    page.should have_content public_todo_list.name
    page.should_not have_content private_todo_list.name
  end

end