module LLT
  class Diff::Parser
    class WordDiff
      include HashContainable

      container_alias :diff

      attr_reader :lemma, :head, :relation, :postag

      xml_tag :word
    end
  end
end

