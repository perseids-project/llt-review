module LLT
  module Diff::Parser::Difference
    class Word
      include LLT::Diff::Parser::HashContainable
      include LLT::Diff::Parser::DiffReporter

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

