module LLT
  module Diff::Treebank::Difference
    class Attribute < Generic
      def write_to_report(report, unique)
        container = report[report_location]
        container.add_wrong(unique)
        container[item.to_s].add_wrong(unique)
      end
    end
  end
end
