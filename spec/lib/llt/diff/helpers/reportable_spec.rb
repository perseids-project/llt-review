require 'spec_helper'

describe LLT::Diff::Helpers::Reportable do
  let(:dummy) { Class.new { include LLT::Diff::Helpers::Reportable } }

  describe "#clone" do
    it "performs a deep copy including all container contents" do
      d = dummy.new('id')
      5.times { |i| d.add(dummy.new("id#{i}", 1)) }
      d['id1'].add(dummy.new('id5'))

      cloned = d.clone
      cloned.increment
      cloned_id5 = cloned['id1']['id5']
      d_id5 = d['id1']['id5']
      cloned_id5.increment
      cloned_id5.add(dummy.new('id6'))

      cloned.should_not == d
      cloned.total.should == 2
      d.total.should == 1
      d_id5.total.should_not == cloned_id5.total
      d_id5['id6'].should_not == cloned_id5['id6']
    end
  end
end
