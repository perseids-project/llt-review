module LLT
  class Diff::Alignment
    class Word
      include Diff::Helpers::HashContainable

      attr_accessor :text

      def to_s
        @text
      end

      def translation
        @translation ||= @container.values.map(&:to_s).join(' ')
      end

      def compare(other, diff_container)
      end
    end
  end
end
