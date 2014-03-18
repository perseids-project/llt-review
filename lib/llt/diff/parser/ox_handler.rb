require 'ox'

module LLT
  class Diff::Parser
    class OxHandler < Ox::Sax

      attr_reader :result

      def initialize
        @result = ParseResult.new
      end

      def parse(data)
        Ox.sax_parse(self, data)
      end

      def start_element(name)
        case name
        when :word     then @in_word = true
        when :sentence then @in_sentence = true
        end
      end

      def end_element(name)
        case name
        when :word     then @in_word = false
        when :sentence then @in_sentence = false
        end
      end

      def attr(name, value)
        case
        when @in_word
          if name == :id
            register_word(value)
          else
            @word.send("#{name}=", value)
          end
        when @in_sentence
          register_sentence(value) if name == :id
        end
      end

      private

      def parse_sentence
        @sentence_id
      end

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
