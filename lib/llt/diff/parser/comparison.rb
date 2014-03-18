module LLT
  class Diff::Parser
    class Comparison
      include HashContainable

      xml_tag :comparison

      def initialize(gold, reviewable)
        @gold       = gold
        @reviewable = reviewable
        @container  = {}
      end

      def id
        "#{@gold.id}---#{@reviewable.id}"
      end

      def xml_attributes
        { gold_id: @gold.id, review_id: @reviewable.id }
      end

      def stats
        "<stats/>"
      end
    end
  end
end
