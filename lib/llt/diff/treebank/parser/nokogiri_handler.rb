require 'nokogiri'

module LLT
  class Diff::Treebank::Parser
    class NokogiriHandler < Nokogiri::XML::SAX::Document

      include Diff::Helpers::Parsing::Helper
      include Diff::Helpers::Parsing::Helper::ForNokogiri
      include Helper

      def parse(data)
        Nokogiri::XML::SAX::Parser.new(self).parse(data)
      end

      def start_element(name, attrs = [])
        case name
        when 'word'     then register_word(attrs)
        when 'sentence' then register_sentence(first_val(attrs))
        end
      end

      private

      def register_word(attrs)
        super(first_val(attrs))
        attrs.each { |k, v| @word.send("#{k}=", v) }
      end
    end
  end
end
