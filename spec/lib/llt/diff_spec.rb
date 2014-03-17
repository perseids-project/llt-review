require 'spec_helper'

describe LLT::Diff do
  it 'should have a version number' do
    LLT::Diff::VERSION.should_not be_nil
  end

  def diff(gold, *review)
    LLT::Diff.new(gold, review)
  end

  describe "#compare" do
    it "creates a diff report of a gold and review annotation" do
      gold = <<-EOF
        <sentence id="21" document_id="Perseus:text:1999.02.0002" subdoc="Book=2:chapter=5" span="In3:erat0">
          <word id="1" form="In" lemma="in1" postag="r--------" head="5" relation="AuxP"/>
          <word id="2" form="eo" lemma="is1" postag="p-s---nb-" head="3" relation="ATR"/>
          <word id="3" form="flumine" lemma="flumen1" postag="n-s---nb-" head="1" relation="ADV"/>
          <word id="4" form="pons" lemma="pons1" postag="n-s---mn-" head="5" relation="SBJ"/>
          <word id="5" form="erat" lemma="sum1" postag="v3siia---" head="0" relation="PRED"/>
        </sentence>
      EOF

      review = <<-EOF
        <sentence id="21" document_id="Perseus:text:1999.02.0002" subdoc="Book=2:chapter=5" span="In3:erat0">
          <word id="1" form="In" lemma="in1" postag="r--------" head="4" relation="AuxP"/>
          <word id="2" form="eo" lemma="is1" postag="p-s---nb-" head="3" relation="ATR"/>
          <word id="3" form="flumine" lemma="flumen2" postag="n-s---nd-" head="1" relation="ADV"/>
          <word id="4" form="pons" lemma="pons1" postag="n-s---mn-" head="5" relation="OBJ"/>
          <word id="5" form="erat" lemma="sum1" postag="v3siia---" head="0" relation="PRED"/>
        </sentence>
      EOF

      d = diff(gold, review)
      result = d.compare
      result.should have(1).item         # we had one reviewable annotation
      result[0].should have(1).item      # one sentence with differences
      result[0][21].should have(3).items # and 3 words with differences
    end
  end
end
