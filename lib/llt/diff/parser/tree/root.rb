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

      def relation
        "ROOT"
      end
      alias_method :lemma, :relation
      alias_method :postag, :relation
    end
  end
end
