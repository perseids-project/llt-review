module LLT
  class Diff::Parser
    class SentenceDiff
      include HashContainable

      xml_tag :sentence

      def stats
        "<stats/>"
      end
    end
  end
end
