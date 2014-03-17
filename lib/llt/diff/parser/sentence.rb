module LLT
  class Diff::Parser
    class Sentence
      def initialize(id)
        @id = id
        @words  = {}
      end

      def add_word(id, word)
        @words[id] = word
      end

      def report
        @report ||= create_report
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

