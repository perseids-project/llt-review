require 'spec_helper'

describe LLT::Diff::Parser::Postag do
  let(:postag) { LLT::Diff::Parser::Postag.new('v3siia---') }

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

  describe "#clean_analysis" do
    it "returns only datapoints that are used" do
      res = {
        part_of_speech: 'v',
        person: '3',
        number: 's',
        tense: 'i',
        mood: 'i',
        voice: 'a',
      }
      postag.clean_analysis.should == res
    end
  end
end
