require 'spec_helper'

describe LLT::Diff do
  it 'should have a version number' do
    LLT::Diff::VERSION.should_not be_nil
  end

  let(:differ) { LLT::Diff.new }

  let(:g1) do
    <<-EOF
      <treebank>
        <sentence id="21" document_id="Perseus:text:1999.02.0002" subdoc="Book=2:chapter=5" span="In3:erat0">
          <word id="1" form="In" lemma="in1" postag="r--------" head="5" relation="AuxP"/>
          <word id="2" form="eo" lemma="is1" postag="p-s---nb-" head="3" relation="ATR"/>
          <word id="3" form="flumine" lemma="flumen1" postag="n-s---nb-" head="1" relation="ADV"/>
          <word id="4" form="pons" lemma="pons1" postag="n-s---mn-" head="5" relation="SBJ"/>
          <word id="5" form="erat" lemma="sum1" postag="v3siia---" head="0" relation="PRED"/>
        </sentence>
      </treebank>
    EOF
  end

  let(:r1) do
    <<-EOF
      <treebank>
        <sentence id="21" document_id="Perseus:text:1999.02.0002" subdoc="Book=2:chapter=5" span="In3:erat0">
          <word id="1" form="In" lemma="in1" postag="r--------" head="4" relation="AuxP"/>
          <word id="2" form="eo" lemma="is1" postag="p-s---nb-" head="3" relation="ATR"/>
          <word id="3" form="flumine" lemma="flumen2" postag="n-s---nd-" head="1" relation="ADV"/>
          <word id="4" form="pons" lemma="pons1" postag="n-s---mn-" head="5" relation="OBJ"/>
          <word id="5" form="erat" lemma="sum1" postag="v3siia---" head="0" relation="PRED"/>
        </sentence>
      </treebank>
    EOF
  end

  describe "#diff" do
    it "creates a diff report of a gold and review annotation" do
      allow(differ).to receive(:get_from_uri).with(:uri_for_g1) { g1 }
      allow(differ).to receive(:get_from_uri).with(:uri_for_r1) { r1 }

      result = differ.diff([:uri_for_g1], [:uri_for_r1])
      result.should have(1).item         # we had one reviewable annotation
      result[0].should have(1).item      # one sentence with differences
      result[0][21].should have(3).items # and 3 words with differences
    end

    it "takes multiple gold and review files" do
      allow(differ).to receive(:get_from_uri).with(:uri_for_g1) { g1 }
      allow(differ).to receive(:get_from_uri).with(:uri_for_g2) { g1 }
      allow(differ).to receive(:get_from_uri).with(:uri_for_r1) { r1 }
      allow(differ).to receive(:get_from_uri).with(:uri_for_r2) { r1 }

      result = differ.diff(%i{ uri_for_g1 uri_for_g2 }, %i{ uri_for_r1 uri_for_r2 })
      result.should have(4).items # we have two times two reviewable annotations now
    end
  end

  describe "#report" do
    it "analyses occurences of lemmata, head, relation, postags... of passed uris" do
      allow(differ).to receive(:get_from_uri).with(:uri_for_g1) { g1 }
      result = differ.report(:uri_for_g1)
      result.should have(1).item
      expected_report = {
        sentence: { total: 1 },
        word: { total: 5 },
        head: { total: 5 },
        relation: {
          total: 5,
          'ADV' => { total: 1 },
          'ATR' => { total: 1 },
          'AuxP' => { total: 1 },
          'PRED' => { total: 1 },
          'SBJ' => { total: 1 }
        },
        lemma: {
          total: 5,
          'flumen1' => { total: 1 },
          'in1' => { total: 1 },
          'is1' => { total: 1 },
          'pons1' => { total: 1 },
          'sum1' => { total: 1 },
        },
        postag: {
          total: 5,
          datapoints: {
            total: 45,
            part_of_speech: {
              total: 5,
              'r' => { total: 1 },
              'p' => { total: 1 },
              'n' => { total: 2 },
              'v' => { total: 1 }
            },
            person: {
              total: 1,
              '3' => { total: 1 },
            },
            number: {
              total: 4,
              's' =>  { total: 4 },
            },
            tense: {
              total: 1,
              'i' => { total: 1 },
            },
            mood: {
              total: 1,
              'i' => { total: 1 },
            },
            voice: {
              total: 1,
              'a' => { total: 1 },
            },
            gender: {
              total: 3,
              'n' => { total: 2 },
              'm' => { total: 1 },
            },
            case: {
              total: 3,
              'b' => { total: 2 },
              'n' => { total: 1 },
            },
          }
        }
      }
      result.first.report.should == expected_report
    end
  end
end
