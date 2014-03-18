module LLT
  class Diff::Parser
    module ParseHelper
      def initialize
        @result = ParseResult.new
      end

      def result
        @result
      end

      private

      def register_sentence(value)
        @sentence = Sentence.new(value.to_i)
        @result.add(@sentence)
      end

      def register_word(value)
        @word = Word.new(value.to_i)
        @sentence.add(@word)
      end
    end
  end
end
