module LLT
  class Diff::Parser::Tree
    class Root
      include Helper

      attr_reader :tree, :head

      def initialize(tree)
        @tree = tree
        @container = {}
      end

      def id
        0
      end

      def head_id
      end

      def seed
      end
    end
  end
end
