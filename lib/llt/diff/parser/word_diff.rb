module LLT
  class Diff::Parser
    class WordDiff
      include HashContainable

      attr_reader :lemma, :head, :relation, :postag

      xml_tag :word
    end
  end
end

