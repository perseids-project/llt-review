require 'nokogiri'

module LLT
  class Review::Treebank::Parser
    class NokogiriHandler < Nokogiri::XML::SAX::Document

      include Review::Helpers::Parsing::Helper
      include Review::Helpers::Parsing::Helper::ForNokogiri
      include Helper

      def parse(data)
        Nokogiri::XML::SAX::Parser.new(self).parse(data)
      end

      def start_element(name, attrs = [])
        case name
        when 'word'     then register_word(attrs)
        when 'sentence' then register_sentence(first_val(attrs))
        when 'treebank' then register_treebank_attrs(attrs)
        when 'annotator' then @in_annotator = true
        end

        if @in_annotator
          set_annotator_variable(name, true)
        end
      end

      def end_element(name, attrs = [])
        if name == 'annotator'
          @in_annotator = false
        end

        if @in_annotator
          set_annotator_variable(name, false)
        end
      end

      def characters(string)
        if @in_annotator
          parse_annotator_values(string)
        end
      end

      private

      def register_word(attrs)
        super(attrs.shift.last) # need to shift, we don't want the id in the next step
        attrs.each { |k, v| @word.send("#{k}=", v) }
      end

      def register_treebank_attrs(attrs)
        hsh = Hash[attrs]
        register_language(hsh['xml:lang'])
        register_format(hsh['format'])
      end
    end
  end
end
