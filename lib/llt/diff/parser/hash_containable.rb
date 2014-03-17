# This shouldn't be here - extract to core and reuse the Containable module

module LLT
  class Diff::Parser
    module HashContainable
      include Enumerable

      attr_reader :container, :id

      def initialize(id = nil)
        @id = id
        @container = {}
      end

      def add(element)
        @container[element.id] = element
      end

      def each(&blk)
        @container.each(&blk)
      end

      def empty?
        @container.empty?
      end

      def [](id)
        @container[id]
      end

      def size
        @container.size
      end

      private

      def counter_hash
        Hash.new(0)
      end

      def self.included(klass)
        klass.extend(ClassMethods)
      end

      module ClassMethods
        def container_alias(al)
          alias_method al, :container
          alias_method "no_#{al}?", :empty?
        end
      end
    end
  end
end
