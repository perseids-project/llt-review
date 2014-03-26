module LLT
  class Diff::Parser::Tree
    class Element < Root
      extend Forwardable
      def_delegators :@item, :id, :relation, :lemma, :postag

      def initialize(item, tree)
        super(tree)
        @item = item
      end

      def head_id
        @item.head
      end

      def seed
        h = @tree[head_id]
        h.add(self)
        @head = h
      end
    end
  end
end
