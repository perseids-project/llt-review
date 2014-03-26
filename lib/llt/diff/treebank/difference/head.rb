module LLT
  module Diff::Parser::Difference
    class Head < Attribute
      def write_to_report(report, unique)
        report[report_location].add_wrong(unique)
      end

      def report_location
        :heads
      end
    end
  end
end

