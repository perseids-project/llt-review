require 'nokogiri'

module LLT
  class Review::Alignment::Parser
    class NokogiriHandler < Nokogiri::XML::SAX::Document

      include Review::Helpers::Parsing::Helper
      include Review::Helpers::Parsing::Helper::ForNokogiri
      include Helper

      def parse(data)
        Nokogiri::XML::SAX::Parser.new(self).parse(data)
      end

      def start_element(name, attrs = [])
        case name
        when 'w'        then register_word(first_val(attrs))
        when 'text'     then @in_text = true
        when 'refs'     then register_translation(first_val(attrs)) unless @original
        when 'wds'      then set_orig_or_translation(Hash[attrs]['lnum'])
        when 'sentence' then register_sentence(Hash[attrs]['id'])
        when 'language' then set_languages(attrs)
        end
      end

      def end_element(name)
        @in_text = false if name == 'text'
      end

      def characters(string)
        set_text(string)
      end

      private

      def set_languages(attrs)
        hsh = Hash[attrs]
        lang = hsh['xml:lang']
        hsh['lnum'] == 'l1' ? @lang1 = lang : @lang2 = lang
      end
    end
  end
end

