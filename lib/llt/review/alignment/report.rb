module LLT
  class Review::Alignment
    class Report < Review::Common::Report
      require 'llt/review/alignment/report/generic'
      require 'llt/review/alignment/report/word'
      require 'llt/review/alignment/report/translation'

      private

      def namespace
        Report
      end
    end
  end
end
