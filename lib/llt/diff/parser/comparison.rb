module LLT
  class Diff::Parser
    class Comparison
      include HashContainable

      xml_tag :comparison

      def initialize(gold_id, review_id)
        @gold_id   = gold_id
        @review_id = review_id
        @container = {}
      end

      def id
        "#{@gold_id}---#{@review_id}"
      end

      def xml_attributes
        { gold_id: @gold_id, review_id: @review_id }
      end
    end
  end
end
