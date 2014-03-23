module LLT
  module Diff::Parser::Difference
    class Attribute < Generic
      def write_to_report(report, unique)
        container = report[report_location]
        container.add_wrong(unique)
        container[diff_location].add_wrong(unique)
      end

      def diff_location
        @original
      end
    end
  end
end
