module LLT
  class Diff::Parser
    class Reviewable
      include HashContainable

      container_alias :diff

      def initialize(id, sentences)
        super(id)
        @sentences = sentences
      end

      def compare(gold)
        gold.each do |gold_id, sentence|
          difference = sentence.compare(@sentences[gold_id])
          add(difference) if difference.any?
        end
      end
    end
  end
end
