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
end
