module LLT
  class Diff::Parser::Tree
    class Root < Element
      def initialize(tree)
        @tree = tree
      end

      def id
        0
      end

      def head_id
      end
    end
  end
end
