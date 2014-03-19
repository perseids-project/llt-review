module LLT
  class Diff::Parser
    class Sentence
      include HashContainable

      container_alias :words

      def initialize(id)
        super
        @comparable_elements = %i{ lemma postag head relation }
      end

      def report
        @report ||= create_report
      end

      def compare(other)
        diff = SentenceDiff.new(self)
        words.each do |id, word|
          other_word = other[id]
          @comparable_elements.each do |comparator|
            a, b = [word, other_word].map { |w| w.send(comparator).to_s }
            if a != b
              d = diff[id] ||= WordDiff.new(id)
              d.send("#{comparator}=", [a, b])
            end
          end
        end

        diff
      end

      private

      def create_report
        report_hash.each do |category, res|
          words.each { |_, word| res[word.send(category)] += 1 }
        end.merge(words: { total: size })
      end

      TO_COUNT = %i{ relation lemma postag }
      def report_hash
        Hash[TO_COUNT.map { |c| [c, counter_hash ]}]
      end
    end
  end
end

