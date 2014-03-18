require 'spec_helper'

describe LLT::Diff::Parser::HashContainable do
  let(:dummy) { Class.new { include LLT::Diff::Parser::HashContainable }.new }

  describe "#merge_reports" do
    it "merges count figures from two hashes" do
      h1 = { x: { a: 1, 'b' => 3 }}
      h2 = { x: { a: 2, 'b' => 2 }}
      res = dummy.send(:merge_reports, h1, h2)
      res.should ==  { x: { a: 3, 'b' => 5 } }
    end
  end

  describe "#sort_report" do
    it "sorts reports by their numeric values" do
      h = { x: { a: 3, b: 5 } }
      dummy.send(:sort_report, h).should == { x: { b: 5, a: 3 } }
    end

    it "sorts alphabetically if the numeric value is equal" do
      h = { x: { c: 3, a: 3, b: 5 } }
      dummy.send(:sort_report, h).should == { x: { b: 5, a: 3, c: 3 } }
    end
  end
end
