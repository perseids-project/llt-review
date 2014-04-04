module LLT
  class Diff::Alignment::Report
    class Generic < Diff::Common::Report::Generic
      def collect_reports(words)
        return unless @reports_to_request
        words.each { |_, word| add(word.report) }
      end
    end
  end
end

