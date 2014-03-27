require 'nokogiri'

module LLT
  class Diff::Alignment::Parser
    class NokogiriHandler < Nokogiri::XML::SAX::Document

      include Diff::Helpers::Parsing::Helper
      include Diff::Helpers::Parsing::Helper::ForNokogiri
      include Helper

      def parse(data)
        Nokogiri::XML::SAX::Parser.new(self).parse(data)
      end

      def start_element(name, attrs = [])
        case name
        when 'w'        then register_word(first_val(attrs))
        when 'text'     then @in_text = true
        when 'refs'     then register_translation(first_val(attrs)) unless @original
        when 'wds'      then set_orig_or_translation(first_val(attrs))
        when 'sentence' then register_sentence(first_val(attrs))
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

