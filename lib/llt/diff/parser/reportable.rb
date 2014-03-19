module LLT
  class Diff::Parser
    module Reportable
      include HashContainable
      include Comparable

      attr_reader :total

      def initialize(id, total = 1)
        super
        @total = total
      end


      def increment
        @total += 1
      end

      def add(element)
        if el = @container[element.id]
          el.increment
        else
          @container[element.id] = element
        end
      end

      def xml_attributes
        { name: @id, total: @total }
      end

      def <=>(other)
        [@total, @id] <=> [other.total, other.id]
      end
    end
  end
end
