module LLT
  class Diff::Parser
    # This class is redundant right now, we keep it around because we
    # still need to decide if we show datapoint diffs
    class PostagDiff
      attr_reader :original, :new

      def initialize(original, new)
        @original = original
        @new = new
      end
    end
  end
end
