module LLT
  class Diff::Treebank::Report
    class Generic < Diff::Common::Report::Generic
      def collect_reports(words)
        return unless @reports_to_request
        words.each { |_, word| add(word[@reports_to_request].report) }
      end
    end
  end
end
