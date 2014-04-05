module LLT
  class Review::Alignment
    class Sentence < Review::Common::Sentence

      attr_accessor :lang1, :lang2

      private

      def report_container
        { words: Report::Generic.new(:words, size, true) }
      end

      def diff_namespace
        Review::Alignment::Difference
      end
    end
  end
end
