module LLT
  class Diff::Treebank::Parser
    module Helper
      def initialize
        @result = Result.new
      end

      def result
        @result
      end

      private

      def register_sentence(value)
        @sentence = Diff::Treebank::Sentence.new(value.to_i)
        @result.add(@sentence)
      end

      def register_word(value)
        @word = Diff::Treebank::Word.new(value.to_i)
        @sentence.add(@word)
      end
    end
  end
end
