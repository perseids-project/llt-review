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

  describe "#report" do
    xit "returns a report hash of the postag" do
      res = {
        datapoints: {
          total: 9,
          part_of_speech: { total: 1, 'v' => { total: 1 } },
          person: { total: 1, '3' => { total: 1 }, },
          number: { total: 1, 's' =>  { total: 1 }, },
          tense: { total: 1, 'i' => { total: 1 }, },
          mood: { total: 1, 'i' => { total: 1 }, },
          voice: { total: 1, 'a' => { total: 1 }, },
        }
      }

      postag.report.should == res
    end
  end
end
