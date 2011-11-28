require "spec_helper"

describe Watchable do

  let(:user) { Factory(:user) }

  before do
    user.extend Watchable
  end

  describe "watch a todo list" do

    context "when todo list is public and user doesn't own todo list" do

      let(:todo_list) { Factory(:todo_list, :private => false) }

      it "can watch a todo list" do
        user.can_watch?(todo_list).should be_true
      end

      it "can creates a watching relationship with todo list" do
        lambda {
          user.watch! todo_list
        }.should change(user.watchings, :count).by(1)

        user.watching?(todo_list).should be_true
      end

    end

  end

  describe "unwatch a todo list" do

    context "when user is watching a todo list" do

      let(:todo_list) { Factory(:todo_list, :private => false) }

      before do
        Factory.create(:watching, :watcher => user, :watched_list => todo_list)
      end

      it "can remove a watching relationship with todo list" do
        lambda {
          user.unwatch! todo_list
        }.should change(user.watchings, :count).by(-1)

        user.watching?(todo_list).should be_false
      end

    end

  end

end