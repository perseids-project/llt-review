module LLT
  module Review::Helpers::Parsing
    class Result
      attr_accessor :format, :lang

      def annotators
        @annotators ||= Helper::Annotators.new
      end

      include Core::Structures::HashContainable
    end
  end
end
