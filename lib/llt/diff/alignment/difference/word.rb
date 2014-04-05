module LLT
  module Diff::Alignment::Difference
    class Word < Diff::Common::Difference::Word
      def diff_id
        @diff_id ||= "#{@id}:#{item.text}|#{item.translation}"
      end
    end
  end
end

