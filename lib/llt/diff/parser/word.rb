module LLT
  class Diff::Parser
    class Word
      attr_accessor :form, :lemma, :postag, :head, :relation

      def initialize(id)
        @id = id
      end
    end
  end
end
