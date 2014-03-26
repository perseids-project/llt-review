require 'nokogiri'

module LLT
  class Diff::Treebank::Parser
    class NokogiriHandler < Nokogiri::XML::SAX::Document

      include Helper

      def parse(data)
        Nokogiri::XML::SAX::Parser.new(self).parse(data)
      end

      def start_element(name, attrs = [])
        case name
        when 'word'
          register_word(attrs.shift.last.to_i)
          attrs.each { |k, v| @word.send("#{k}=", v) }
        when 'sentence'
          register_sentence(attrs.first.last.to_i)
        end
      end
    end
  end
end
