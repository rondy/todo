require "spec_helper"

describe WatchedListsHelper do

  let(:user) { Factory(:user) }
  let(:todo_list) { Factory.create(:todo_list) }

  before { helper.stub :current_user => user }

  it "renders link to unwatch a todo list" do
    helper.link_to_unwatch(todo_list).should eq %{<a href="/watched_lists/#{todo_list.to_param}" data-method="delete" rel="nofollow">Unwatch</a>}
  end

  it "renders link to watch a todo list" do
    helper.link_to_watch(todo_list).should eq %{<a href="/watched_lists?todo_list_id=#{todo_list.to_param}" data-method="post" rel="nofollow">Watch</a>}
  end

  describe "toggle watching links" do

    before do
      user.stub(:can_watch?).with(todo_list).and_return(true)
      user.stub(:watching?).with(todo_list).and_return(is_user_watching_todo_list)
    end

    context "when user isn't watching todo list" do

      let(:is_user_watching_todo_list) { true }

      it "renders link to unwatch a todo list" do
        helper.should_receive(:link_to_unwatch).with(todo_list)
        helper.toggle_watching(todo_list)
      end

    end

    context "when user is watching todo list" do

      let(:is_user_watching_todo_list) { false }

      it "renders link to watch a todo list" do
        helper.should_receive(:link_to_watch).with(todo_list)
        helper.toggle_watching(todo_list)
      end

    end

  end

end