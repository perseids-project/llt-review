module LLT
  class Diff::Parser::Report::Postag
    class Datapoint
      include Diff::Parser::Reportable

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
