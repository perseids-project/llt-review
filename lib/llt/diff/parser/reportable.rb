module LLT
  class Diff::Parser
    module Reportable
      include HashContainable

      attr_reader :id, :total

      def initialize(id, total = 1)
        super(id)
        @total = total
      end

      def add(element)
        if el = @container[element.id]
          el.add_total(element)
          element.container.each do |_, nested_el|
            el.add(nested_el)
          end
        else
          @container[element.id] = element
        end
      end

      def add_total(element)
        @total += element.total
      end

      def increment
        @total += 1
      end

      def xml_tag
        self.class.name.scan(/::(\w+)$/)[0].first.downcase
      end

      def xml_attributes
        { name: @id, total: @total }
      end

      def sort
        Hash[
          @container.sort do |(a_id, a_r), (b_id, b_r)|
            comp = b_r.total <=> a_r.total
            comp.zero? ? a_id <=> b_id : comp
          end
        ]
      end

      def sort!
        each { |_, el| el.sort! }
        @container = sort
      end

      def new_clone
        cloned = old_clone
        cloned.clone_container
        cloned
      end

      def clone_container
        # looks a little weird, but I don't think we'll ever call that method
        # somewhere else, so it should be ok to do
        @container = Hash[map { |id, content| [id, content.clone] }]
      end
      alias_method :old_clone, :clone
      alias_method :clone, :new_clone
    end
  end
end
