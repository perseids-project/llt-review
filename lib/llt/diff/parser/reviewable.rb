module LLT
  class Diff::Parser
    class Reviewable
      include HashContainable

      container_alias :diff

      xml_tag :reviewable

      def initialize(id, sentences)
        super(id)
        @sentences = sentences
      end

      def compare(gold)
        comparison = Comparison.new(gold, self)

        gold.sentences.each do |sentence_id, sentence|
          difference = sentence.compare(@sentences[sentence_id])
          comparison.add(difference) if difference.any?
        end

        add(comparison) if comparison.any?
      end

      def to_xml
        container_to_xml
      end
    end
  end
end
