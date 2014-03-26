require 'spec_helper'

describe LLT::Diff::Trebank::Parser do
  let(:parser) { LLT::Diff::Treebank::Parser.new() }
  let(:data) { <<-EOF }
    <sentence id="21" document_id="Perseus:text:1999.02.0002" subdoc="Book=2:chapter=5" span="In3:erat0">
      <word id="1" form="In" lemma="in1" postag="r--------" head="5" relation="AuxP"/>
      <word id="2" form="eo" lemma="is1" postag="p-s---nb-" head="3" relation="ATR"/>
      <word id="3" form="flumine" lemma="flumen1" postag="n-s---nb-" head="1" relation="ADV"/>
      <word id="4" form="pons" lemma="pons1" postag="n-s---mn-" head="5" relation="SBJ"/>
      <word id="5" form="erat" lemma="sum1" postag="v3siia---" head="0" relation="PRED"/>
    </sentence>
  EOF

  describe "#parse" do
    it "returns a hash of parsed sentences" do
      result = parser.parse(data)
      result[21].should be_true
    end
  end
end
