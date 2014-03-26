module LLT
  module Diff::Helpers
    module Parsing
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
