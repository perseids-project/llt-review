module LLT
  class Review::Alignment
    class Translation
      include Core::Structures::HashContainable

      attr_accessor :text

      def to_s
        @text
      end
    end
  end
end
