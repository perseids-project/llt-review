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

  let(:g2) do
    <<-EOF
      <treebank>
        <sentence id="21" document_id="Perseus:text:1999.02.0002" subdoc="Book=2:chapter=5" span="In3:erat0">
          <word id="1" form="In" lemma="in1" postag="r--------" head="5" relation="AuxP"/>
          <word id="2" form="eo" lemma="is1" postag="p-s---nb-" head="3" relation="ATR"/>
          <word id="3" form="flumine" lemma="flumen1" postag="n-s---nb-" head="1" relation="ADV"/>
          <word id="4" form="pons" lemma="pons1" postag="n-s---mn-" head="5" relation="SBJ"/>
          <word id="5" form="erat" lemma="sum1" postag="v3siia---" head="0" relation="PRED"/>
        </sentence>
        <sentence id="22" document_id="Perseus:text:1999.02.0002" subdoc="Book=2:chapter=5" span="In3:erat0">
          <word id="1" form="In" lemma="in1" postag="r--------" head="5" relation="AuxP"/>
          <word id="2" form="eo" lemma="is1" postag="p-s---nb-" head="3" relation="ATR"/>
          <word id="3" form="flumine" lemma="flumen1" postag="n-s---nb-" head="1" relation="ADV"/>
          <word id="4" form="pons" lemma="pons1" postag="n-s---mn-" head="5" relation="SBJ"/>
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
      diff = result[0][21]
      w1, w3, w4 = diff.take(1, 3, 4).map(&:diff)

      w1[:head].original.should == '5'
      w1[:head].new.should == '4'

      w3[:lemma].original.should == 'flumen1'
      w3[:lemma].new.should == 'flumen2'
      w3[:postag].original.should == 'n-s---nb-'
      w3[:postag].new.should == 'n-s---nd-'
      w3[:postag][:case].original.should == 'b'
      w3[:postag][:case].new.should == 'd'

      w4[:relation].original.should == 'SBJ'
      w4[:relation].new.should == 'OBJ'
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
      allow(differ).to receive(:get_from_uri).with(:uri_for_g1) { g2 }
      allow(differ).to receive(:get_from_uri).with(:uri_for_g2) { g2 }
      result = differ.report(:uri_for_g1)
      result.should have(1).item
      report = result.first
      report[:sentences].total.should == 2
      report[:words].total.should == 10
      report[:heads].total.should == 10

      relations = report[:relations]
      relations.total.should == 10
      relations['ADV'].total.should == 2
      relations['ATR'].total.should == 2
      relations['AuxP'].total.should == 2
      relations['PRED'].total.should == 2
      relations['SBJ'].total.should == 2

      lemmata = report[:lemmata]
      lemmata.total.should == 10
      lemmata['flumen1'].total.should == 2
      lemmata['in1'].total.should == 2
      lemmata['is1'].total.should == 2
      lemmata['pons1'].total.should == 2
      lemmata['sum1'].total.should == 2

      postags = report[:postags]
      postags.total.should == 10
      postags["r--------"].total.should == 2
      postags["p-s---nb-"].total.should == 2
      postags["n-s---nb-"].total.should == 2
      postags["n-s---mn-"].total.should == 2
      postags["v3siia---"].total.should == 2

      datapoints = postags[:datapoints]
      datapoints.total.should == 90

      pos = datapoints[:parts_of_speech]
      pos.total.should == 10
      pos['r'].total.should == 2
      pos['p'].total.should == 2
      pos['n'].total.should == 4
      pos['v'].total.should == 2

      persons = datapoints[:persons]
      persons.total.should == 2
      persons['3'].total.should == 2

      numbers = datapoints[:numbers]
      numbers.total.should == 8
      numbers['s'].total.should == 8

      tenses = datapoints[:tenses]
      tenses.total.should == 2
      tenses['i'].total.should == 2

      moods = datapoints[:moods]
      moods.total.should == 2
      moods['i'].total.should == 2

      voices= datapoints[:voices]
      voices.total.should == 2
      voices['a'].total.should == 2

      genders = datapoints[:genders]
      genders.total.should == 6
      genders['n'].total.should == 4
      genders['m'].total.should == 2

      cases = datapoints[:cases]
      cases.total.should == 6
      cases['b'].total.should == 4
      cases['n'].total.should == 2
    end
  end
end
