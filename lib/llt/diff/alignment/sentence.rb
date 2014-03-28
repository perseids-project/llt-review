module LLT
  class Diff::Alignment
    class Sentence < Diff::Common::Sentence

      attr_accessor :lang1, :lang2

      private

      def diff_namespace
        Diff::Alignment::Difference
      end
    end
  end
end
