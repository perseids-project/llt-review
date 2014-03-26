module LLT
  class Diff::Treebank
    class Reviewable
      include Diff::Helpers::HashContainable

      container_alias :diff

      xml_tag :reviewable

      attr_reader :sentences

      def initialize(id, sentences)
        super(id)
        @sentences = sentences
      end

      def compare(gold)
        comparison = Comparison.new(gold, self)
        comparison.compare
        add(comparison) if comparison.any?
      end

      def to_xml
        container_to_xml
      end
    end
  end
end
