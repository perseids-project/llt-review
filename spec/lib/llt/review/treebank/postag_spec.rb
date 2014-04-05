require 'spec_helper'

describe LLT::Review::Treebank::Postag do
  let(:postag) { LLT::Review::Treebank::Postag.new('v3siia---') }

  describe "#analysis" do
    it "decodes the postag into a hash" do
      res = {
        part_of_speech: 'v',
        person: '3',
        number: 's',
        tense: 'i',
        mood: 'i',
        voice: 'a',
        gender: '-',
        case: '-',
        degree: '-',
      }
      postag.analysis.should == res
    end
  end
end
