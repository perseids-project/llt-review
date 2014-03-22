module LLT
  class Diff::Parser
    class SentenceDiff
      include HashContainable

      container_alias :diff
      xml_tag :sentence

      def initialize(sentence)
        super(sentence.id)
        @total = sentence.size
      end

      def diff_id
        @diff_id ||= "#{id}:#{map { |_, v| v.diff_id }.join('::')}"
      end
    end
  end
end
