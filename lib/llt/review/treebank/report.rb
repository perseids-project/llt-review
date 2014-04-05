module LLT
  class Review::Treebank
    class Report < Review::Common::Report
      require 'llt/review/treebank/report/generic'
      require 'llt/review/treebank/report/datapoints'
      require 'llt/review/treebank/report/postags'
      require 'llt/review/treebank/report/lemma'
      require 'llt/review/treebank/report/postag'
      require 'llt/review/treebank/report/postag/datapoint'
      require 'llt/review/treebank/report/relation'

      private

      def namespace
        Report
      end
    end
  end
end
