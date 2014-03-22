module LLT
  class Diff::Parser
    class WordDiff
      include HashContainable
      include DiffReporter

      container_alias :diff
      xml_tag :word

      attr_reader :lemma, :head, :relation, :postag
    end
  end
end

