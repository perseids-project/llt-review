module LLT
  class Diff::Parser
    class Word
      include HashContainable

      attr_accessor :form, :lemma, :head, :relation
      attr_reader :postag

      def postag=(tag)
        @postag = Postag.new(tag)
      end
    end
  end
end
