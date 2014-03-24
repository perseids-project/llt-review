module LLT
  class Diff::Parser
    # This namespace will get extracted to somewhere else eventually
    class Tree
      require 'llt/diff/parser/tree/helper'
      require 'llt/diff/parser/tree/root'
      require 'llt/diff/parser/tree/element'

      include HashContainable

      attr_reader :id, :root

      def initialize(id = nil)
        @id = id
        @root = Root.new(self)
        @container = {}
        @tree = {}
        add(@root)
      end

      def seed(*words)
        words.each { |word| add(Element.new(word, self)) }
        each_value(&:seed)
      end
    end
  end
end
