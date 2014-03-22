module LLT
  class Diff::Parser::Report
    class Postags < Generic
      include Diff::Parser::Reportable

      def initialize(total = 1)
        super(:postags, total)
      end

      def collect_reports(words)
        words.each do |_, word|
          add(Postag.new(word.postag.to_s))
          add(word.postag.report)
        end
      end

      # Sorting is all good, but we want the postags to show up
      # in front of the datapoints
      def sort
        shifter = :datapoints
        sorted = super
        sorted[shifter] = sorted.delete(shifter)
        sorted
      end
    end
  end
end

