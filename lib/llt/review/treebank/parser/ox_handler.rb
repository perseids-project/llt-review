require 'ox'

module LLT
  class Review::Treebank::Parser
    class OxHandler < Ox::Sax

      include Review::Helpers::Parsing::Helper
      include Helper

      def parse(data)
        Ox.sax_parse(self, data)
      end

      def start_element(name)
        case name
        when :word     then @in_word = true
        when :sentence then @in_sentence = true
        when :annotator then @in_annotator = true
        when :treebank then @in_treebank = true
        end

        if @in_annotator
          set_annotator_variable(name, true)
        end
      end

      def end_element(name)
        case name
        when :word     then @in_word = false
        when :sentence then @in_sentence = false
        when :annotator then @in_annotator = false
        end

        if @in_annotator
          set_annotator_variable(name, false)
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
        when @in_treebank
          register_language(value) if name == :"xml:lang"
          register_format(value)   if name == :format
        end
      end

      def text(value)
        if @in_annotator
          parse_annotator_values(value)
        end
      end
    end
  end
end
