require 'ox'

module LLT
  class Diff
    class Parser
      require 'llt/diff/parser/sax_handler'
      require 'llt/diff/parser/difference'
      require 'llt/diff/parser/reviewable'
      require 'llt/diff/parser/diff_container'

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


