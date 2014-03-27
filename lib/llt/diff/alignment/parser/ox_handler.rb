require 'ox'

module LLT
  class Diff::Alignment::Parser
    class OxHandler < Ox::Sax

      include Diff::Helpers::Parsing::Helper
      include Helper

      def parse(data)
        Ox.sax_parse(self, data)
      end

      def start_element(name)
      end

      def end_element(name)
      end

      def attr(name, value)
      end
    end
  end
end
