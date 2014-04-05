module LLT
  class Review::Treebank::Report::Postag
    class Datapoint
      include Review::Helpers::Reportable

      def initialize(tag, id, total = 1)
        super(id, total)
        @tag = tag
      end

      def xml_tag
        @tag
      end
    end
  end
end
