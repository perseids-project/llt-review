require 'nokogiri'

module LLT
  class Diff::Alignment::Parser
    class NokogiriHandler < Nokogiri::XML::SAX::Document

      include Diff::Helpers::Parsing::Helper
      include Helper

      def parse(data)
        Nokogiri::XML::SAX::Parser.new(self).parse(data)
      end

      def start_element(name, attrs = [])
      end
    end
  end
end

