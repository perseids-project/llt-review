module LLT
  class Diff::Treebank
    class Report < Diff::Common::Report
      require 'llt/diff/treebank/report/generic'
      require 'llt/diff/treebank/report/datapoints'
      require 'llt/diff/treebank/report/postags'
      require 'llt/diff/treebank/report/lemma'
      require 'llt/diff/treebank/report/postag'
      require 'llt/diff/treebank/report/postag/datapoint'
      require 'llt/diff/treebank/report/relation'

      private

      def namespace
        Report
      end
    end
  end
end
