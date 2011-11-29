require "spec_helper"

describe TodoListsHelper do

  describe "visibility" do

    subject { helper.visibility(todo_list) }

    context "when todo list is private" do

      let(:todo_list) { stub(:todo_list, :private? => true) }

      it { should eq "<em>(private)</em>" }

    end

    context "when todo_list is not private" do

      let(:todo_list) { stub(:todo_list, :private? => false) }

      it { should be_nil }

    end

  end

end