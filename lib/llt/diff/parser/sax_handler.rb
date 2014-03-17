module LLT
  class Diff::Parser
    class SaxHandler < Ox::Sax
      require 'llt/diff/parser/hash_containable'
      require 'llt/diff/parser/sentence'
      require 'llt/diff/parser/word'

      attr_reader :result

      def initialize
        @result = {}
      end

      # make known when we are in a word element, otherwise we're in a sentence
      def start_element(name)
        @in_word = name == :word
      end

      def attr(name, value)
        if @in_word
          name == :id ? register_word(value) : @word.send("#{name}=", value)
        else
          register_sentence(value) if name == :id
        end
      end

      private

      def parse_sentence
        @sentence_id
      end

      def register_sentence(value)
        id = value.to_i
        @sentence = Sentence.new(id)
        @result[id] = @sentence
      end

      def register_word(value)
        @word = Word.new(value.to_i)
        @sentence.add(@word)
      end

      def parse_word
        puts 'word'
      end
    end
  end
end
