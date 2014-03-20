module LLT
  class Diff::Parser
    class SentenceDiff
      include HashContainable

      xml_tag :sentence

      def initialize(sentence)
        super(sentence.id)
        @total = sentence.size
      end

      def stats
        "<stats/>"
      end
    end
  end
end
