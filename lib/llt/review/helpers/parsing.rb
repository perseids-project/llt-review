module LLT
  module Review::Helpers
    module Parsing
      require 'llt/review/helpers/parsing/helper'
      require 'llt/review/helpers/parsing/result'

      def parse(data)
        io = StringIO.new(data)
        handler.parse(io)
        io.close
        handler.result
      end

      def handler
        @handler ||= begin
          if RUBY_PLATFORM == 'java'
            namespace.const_get(:NokogiriHandler).new
          else
            namespace.const_get(:OxHandler).new
          end
        end
      end

      def namespace
        self.class
      end
    end
  end
end
