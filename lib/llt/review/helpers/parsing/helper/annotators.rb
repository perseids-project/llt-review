module LLT
  module Review::Helpers::Parsing::Helper
    class Annotators
      def initialize
        @annotators = []
      end

      def add(annotator)
        @annotators << annotator
      end
    end
  end
end
