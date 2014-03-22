module LLT
  class Diff::Parser::Report
    class Sentences < Generic
      def initialize(total = 1)
        super(:sentences, total)
      end

      def init_diff
        super
        @unique = nil
      end

      def add_wrong(*)
        @wrong += 1
      end
    end
  end
end

