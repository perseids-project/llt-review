require 'ox'

module LLT
  class Diff
    class Parser
      require 'llt/diff/parser/sax_handler'

      def parse(data)
        Ox.sax_parse(handler, StringIO.new(data))
        handler.result
      end

      def handler
        @handler ||= SaxHandler.new
      end
    end
  end
end


