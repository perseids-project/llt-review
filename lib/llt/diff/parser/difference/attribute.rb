module LLT
  module Diff::Parser::Difference
    class Attribute
      def write_to_report(report, unique)
        report[report_location][@attribute].add_wrong(unique)
      end
    end
  end
end
