module LLT
  class Diff
    class Difference
      attr_accessor :lemma, :postag, :head, :relation

      def initialize(id)
        @id = id
      end
    end
  end
end

