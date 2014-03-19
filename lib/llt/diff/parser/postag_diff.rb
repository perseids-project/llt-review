module LLT
  class Diff::Parser
    class PostagDiff
      attr_reader :original, :new

      def initialize(original, new)
        @original = original
        @new = new
      end
    end
  end
end
