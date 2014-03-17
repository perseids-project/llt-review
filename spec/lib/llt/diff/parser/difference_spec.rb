require 'spec_helper'

describe LLT::Diff::Parser::Difference do
  let(:difference) { LLT::Diff::Parser::Difference.new(1) }

  describe "#to_xml" do
    it "returns differences grouped by original and new" do
      difference.lemma = ['a', 'b']
      res = '<word id="1"><original lemma="a"/><new lemma="b"/></word>'
      difference.to_xml.should == res
    end
  end
end
