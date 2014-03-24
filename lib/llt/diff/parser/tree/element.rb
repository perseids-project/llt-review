module LLT
  class Diff::Parser::Tree
    class Element
      include Helper

      attr_reader :tree, :head

      def initialize(item, tree)
        @item = item
        @tree = tree
        add
      end

      def id
        @item.id
      end

      def head_id
        @item.head
      end

      def seed
        @head = @tree[head_id]
      end

      def add
      end
    end
  end
end
