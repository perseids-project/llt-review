module LLT
  module Diff::Treebank::Difference
    class Word
      include Diff::Helpers::HashContainable
      include Diff::Helpers::DiffReporter

      container_alias :diff
      xml_tag :word

      attr_reader :lemma, :head, :relation, :postag

      private

      def write_to_report(report, unique)
        report[:words].add_wrong(unique)
      end
    end
  end
end

