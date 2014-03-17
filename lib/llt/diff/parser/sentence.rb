module LLT
  class Diff::Parser
    class Sentence
      def initialize(id)
        @id = id
        @words = {}
      end

      def add_word(id, word)
        @words[id] = word
      end
    end
  end
end

