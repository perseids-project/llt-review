module LLT
  class Diff::Treebank
    class Parser
      require 'llt/diff/treebank/parser/helper'
      require 'llt/diff/treebank/parser/result'
      autoload :NokogiriHandler, 'llt/diff/treebank/parser/nokogiri_handler'
      autoload :OxHandler,       'llt/diff/treebank/parser/ox_handler'

      def parse(data)
        io = StringIO.new(data)
        handler.parse(io)
        io.close
        handler.result
      end

      def handler
        @handler ||= begin
          if RUBY_PLATFORM == 'java'
            NokogiriHandler.new
          else
            OxHandler.new
          end
        end
      end
    end
  end
end


