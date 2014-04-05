module LLT
  class Diff::Alignment
    class Translation
      include Diff::Helpers::HashContainable

      attr_accessor :text

      def to_s
        @text
      end
    end
  end
end
