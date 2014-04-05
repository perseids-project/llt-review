module LLT
  module Diff::Common::Difference
    class Word
      include Diff::Helpers::HashContainable
      include Diff::Helpers::DiffReporter

      def xml_tag
        :word
      end

      def diff
        @container
      end

      private

      def write_to_report(report, unique)
        report[:words].add_wrong(unique)
      end
    end
  end
end


