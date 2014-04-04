module LLT
  class Diff::Alignment
    class Report < Diff::Common::Report
      require 'llt/diff/alignment/report/generic'
      require 'llt/diff/alignment/report/word'
      require 'llt/diff/alignment/report/translation'

      private

      def namespace
        Report
      end
    end
  end
end
