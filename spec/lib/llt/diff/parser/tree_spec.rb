require 'spec_helper'

describe LLT::Diff::Parser::Tree do
  let(:tree) { LLT::Diff::Parser::Tree.new }

  describe "#new" do
    it "always comes with a root node" do
      tree.container.should have(1).item
    end

    it "root holds a reference to the tree itself" do
      tree.root.tree.should == tree
    end

    it "root has always id 0" do
      tree[0].should == tree.root
    end
  end

  describe "#seed" do
    let(:w1) { double(id: 1, head: 0) }
    let(:w2) { double(id: 2, head: 3) }
    let(:w3) { double(id: 3, head: 1) }
    let(:words) { [w1, w2, w3] }

    it "adds words to the Tree container" do
      tree.seed(words)
      tree[0].should_not be_nil
      tree[1].should_not be_nil
      tree[2].should_not be_nil
      tree[3].should_not be_nil
      tree[4].should be_nil
    end

  end
end
