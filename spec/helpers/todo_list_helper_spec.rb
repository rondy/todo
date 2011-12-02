require "spec_helper"

describe TodoListsHelper do

  let(:current_user) { Factory(:user) }
  let(:todo_list) { Factory.create(:todo_list) }

  before { helper.stub :current_user => current_user }

  describe "#visibility(todo_list)" do

    subject { helper.visibility(todo_list) }

    context "when todo list is private" do

      before { todo_list.stub(:private? => true) }

      it { should eq "<em>(private)</em>" }

    end

    context "when todo_list is not private" do

      before { todo_list.stub(:private? => false) }

      it { should be_nil }

    end

  end

  describe "#link_to_edit_todo_list(todo_list)" do

    it "renders link to edit a todo list" do
      helper.link_to_edit_todo_list(todo_list).should eq %{<a href="/todo_lists/#{todo_list.id}/edit" class="edit" id="edit_todo_list_#{todo_list.id}">(Edit)</a>}
    end

  end

  describe "#link_to_destroy_todo_list(todo_list)" do

    it "renders link to destroy a todo list" do
      helper.link_to_destroy_todo_list(todo_list).should eq %{<a href="/todo_lists/#{todo_list.id}" class="destroy" data-confirm="Are you sure?" data-method="delete" id="remove_todo_list_#{todo_list.id}" rel="nofollow">(Remove)</a>}
    end

  end

  describe "#links_manage_todo_list(todo_list)" do

    before do
      helper.stub(:link_to_edit_todo_list).with(todo_list).and_return("link to edit list")
      helper.stub(:link_to_destroy_todo_list).with(todo_list).and_return("link to destroy list")
    end

    it do
      helper.links_to_manage_todo_list(todo_list).should eq "link to edit list | link to destroy list"
    end

  end

  describe "#render_action_links_for(todo_list)" do

    context "when user owns todo list" do

      before { current_user.should_receive(:owns?).with(todo_list).and_return(true) }

      it "renders links to manage todo list" do
        helper.should_receive(:links_to_manage_todo_list).with(todo_list)
        helper.render_action_links_for(todo_list)
      end

    end

    context "when user doesn't own todo list" do

      before { current_user.should_receive(:owns?).with(todo_list).and_return(false) }

      it "renders link to toggle watching" do
        helper.should_receive(:link_to_toggle_watching).with(todo_list)
        helper.render_action_links_for(todo_list)
      end

    end

  end

  describe "#link_to_unwatch(todo_list)" do

    it "renders link to unwatch a todo list" do
      helper.link_to_unwatch(todo_list).should eq %{<a href="/watched_lists/#{todo_list.to_param}" class="watching" data-method="delete" id="unwatch_todo_list_#{todo_list.id}" rel="nofollow">Unwatch</a>}
    end

  end

  describe "#link_to_watch(todo_list)" do

    it "renders link to watch a todo list" do
      helper.link_to_watch(todo_list).should eq %{<a href="/watched_lists?todo_list_id=#{todo_list.to_param}" class="watching" data-method="post" id="watch_todo_list_#{todo_list.id}" rel="nofollow">Watch</a>}
    end

  end

  describe "#link_to_toggle_watching(todo_list)" do

    before do
      current_user.stub(:can_watch?).with(todo_list).and_return(true)
      current_user.stub(:watching?).with(todo_list).and_return(is_user_watching_todo_list)
    end

    context "when user isn't watching todo list" do

      let(:is_user_watching_todo_list) { true }

      it "renders link to unwatch a todo list" do
        helper.should_receive(:link_to_unwatch).with(todo_list)
        helper.link_to_toggle_watching(todo_list)
      end

    end

    context "when user is watching todo list" do

      let(:is_user_watching_todo_list) { false }

      it "renders link to watch a todo list" do
        helper.should_receive(:link_to_watch).with(todo_list)
        helper.link_to_toggle_watching(todo_list)
      end

    end

  end

end