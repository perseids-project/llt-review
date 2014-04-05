module LLT
  module Diff::Alignment::Difference
    class Word < Diff::Common::Difference::Word
      def diff_id
        @diff_id ||= "#{@id}:#{original}|#{new}"
      end

      # go right to the translation - we have the nrefs too, not sure
      # if we need them actually
      def original
        @original ||= @container[:translation].original
      end

      def new
        @new ||= @container[:translation].new
      end
    end
  end
end

