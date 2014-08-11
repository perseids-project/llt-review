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
          instance_variable_set("@in_#{name}", true);
        end
      end

      def end_element(name)
        case name
        when :word     then @in_word = false
        when :sentence then @in_sentence = false
        when :annotator then @in_annotator = false
        end

        if @in_annotator
          instance_variable_set("@in_#{name}", false);
        end
      end

      def annotator
        @annotator ||= Annotator.new
      end

      def add_complete_annotator
        if annotator.complete?
          @result.annotators.add(annotator)
          @annotator = nil
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
          params = [:short, :name, :address, :url]
          params.each do |param|
            if instance_variable_get("@in_#{param}")
              annotator.send("#{param}=", value)
              add_complete_annotator
            end
          end
        end
      end
    end
  end
end
