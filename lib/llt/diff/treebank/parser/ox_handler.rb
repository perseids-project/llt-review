require 'ox'

module LLT
  class Diff::Treebank::Parser
    class OxHandler < Ox::Sax

      include Helper

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
    end
  end
end
