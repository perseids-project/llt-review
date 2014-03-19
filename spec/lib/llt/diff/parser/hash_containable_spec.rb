require 'spec_helper'

describe LLT::Diff::Parser::HashContainable do
  let(:dummy) { Class.new { include LLT::Diff::Parser::HashContainable }.new }

  describe "#merge_reports" do
    it "merges count figures from nested hashes" do
      h1 = { x: { a: { total: 1, c: { total: 2 }}, 'b' => { total: 3 }, d: { total: 5}}}
      h2 = { x: { a: { total: 2, c: { total: 3 }}, 'b' => { total: 2 }, e: { total: 6}}}
      res = dummy.send(:merge_reports, h1, h2)
      res.should ==  { x: { a: { total: 3, c: { total: 5 }},
                            'b' => { total: 5 },
                            d: { total: 5},
                            e: { total: 6}}}
    end

    it "takes multiple hashes at once" do
      h1 = { x: { a: { total: 1, c: { total: 2 }}, 'b' => { total: 3 }}}
      h2 = { x: { a: { total: 2, c: { total: 3 }}, 'b' => { total: 2 }}}
      h3 = { x: { a: { total: 1, c: { total: 1 }}, 'b' => { total: 1 }}}
      res = dummy.send(:merge_reports, h1, h2, h3)
      res.should ==  { x: { a: { total: 4, c: { total: 6 }}, 'b' => { total: 6 }}}
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

  describe "#hash_to_xml" do
    it "creates xml out of nested hashes" do
      h1 = { x: { a: { total: 1, c: { total: 2 }}, 'b' => { total: 3 }}}
      res = '<x><a total="1"><c total="2"/></a><b total="3"/></x>'
      dummy.send(:hash_to_xml, h1).should == res
    end
  end
end
