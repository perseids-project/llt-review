module LLT
  module Diff::Treebank::Difference
    class Sentence
      include Diff::Helpers::HashContainable
      include Diff::Helpers::DiffReporter

      container_alias :diff
      xml_tag :sentence

      def diff_id
        @diff_id ||= "#{id}:#{map { |_, v| v.diff_id }.join('::')}"
      end

      private

      def write_to_report(report, unique)
        report[:sentences].add_wrong(unique)
      end
    end
  end
end
