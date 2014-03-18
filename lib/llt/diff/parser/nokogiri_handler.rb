require 'nokogiri'

module LLT
  class Diff::Parser
    class NokogiriHandler < Nokogiri::XML::SAX::Document

      attr_reader :result

      def initialize
        @result = ParseResult.new
      end

      def parse(data)
        Nokogiri::XML::SAX::Parser.new(self).parse(data)
      end

      def start_element(name, attrs = [])
        case name
        when 'word'
          word = Word.new(attrs.shift.last.to_i)
          attrs.each { |k, v| word.send("#{k}=", v) }
          @sentence.add(word)
        when 'sentence'
          @sentence = Sentence.new(attrs.first.last.to_i)
          @result.add(@sentence)
        end
      end
    end
  end
end
