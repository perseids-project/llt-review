module LLT
  class Diff::Treebank::Report
    class Postags < Generic
      def initialize(total = 1)
        super(:postags, total)
      end

      def collect_reports(words)
        words.each do |_, word|
          postag = word[:postag]
          add(Postag.new(postag.to_s))
          add(postag.report)
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

