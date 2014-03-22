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
    end
  end
end
