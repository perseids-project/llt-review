module LLT
  class Diff::Parser
    class WordDiff
      include HashContainable

      container_alias :diff

      attr_reader :lemma, :head, :relation, :postag

      xml_tag :word

      def diff_id
        @diff_id ||= "#{id}:#{map { |_, v| v.diff_id }.join('::')}"
      end
    end
  end
end

