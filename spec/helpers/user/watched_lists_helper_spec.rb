require "spec_helper"

describe User::WatchedListsHelper do

  let(:user) { Factory(:user) }
  let(:todo_list) { Factory.create(:todo_list) }

  before do
    helper.stub :current_user => user
  end

  it "generates link to watch a todo list" do
    user.stub(:can_watch?).with(todo_list).and_return(true)
    user.stub(:watching?).with(todo_list).and_return(false)
    helper.link_to_watch(todo_list).should eq %{<a href="/user/watched_lists?todo_list_id=#{todo_list.to_param}" data-method="post" rel="nofollow">Watch</a>}
  end

end