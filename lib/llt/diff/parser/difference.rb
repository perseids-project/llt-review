module LLT
  class Diff::Parser
    class Difference
      include HashContainable

      attr_accessor :lemma, :postag, :head, :relation
    end
  end
end

