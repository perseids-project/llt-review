module LLT
  class Diff::Parser
    class Sentence
      include HashContainable

      container_alias :words

      def initialize(id)
        super
        @comparable_elements = %i{ lemma postag head relation }
        @diff = {}
      end

      def report
        @report ||= create_report
      end

      def compare(other)
        words.each do |id, word|
          other_word = other[id]
          @comparable_elements.each do |comparator|
            a, b = [word, other_word].map { |w| w.send(comparator) }
            if a != b
              d = @diff[id] ||= Difference.new(id)
              d.send("#{comparator}=", [a, b])
            end
          end
        end

        @diff
      end

      private

      def create_report
        report_hash.each do |category, res|
          @words.each do |id, word|
            res[word.send(category)] += 1
          end
        end
      end

      def report_hash
        %w{ relation }.each_with_object({}) { |e, hsh| hsh[e] = counter_hash }
      end

      def counter_hash
        Hash.new(0)
      end
    end
  end
end

