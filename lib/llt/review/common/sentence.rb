module LLT
  class Review::Common
    class Sentence
      include Core::Structures::HashContainable

      def words
        @container
      end

      def report
        @report ||= create_report
      end

      def compare(other, comparables = nil)
        diff = new_sentence_diff
        words.each do |id, word|
          other_word = other[id] || dummy_word(id)

          word.compare(other_word, diff, comparables)
        end
        diff
      end

      def clone
        cloned = super
        cloned.replace_with_clone(:report)
        cloned
      end

      private

      def dummy_word(id)
        # implemented by subclasses
      end

      def new_sentence_diff
        diff_namespace.const_get(:Sentence).new(self)
      end

      def create_report
        @report ||= begin
          report_container.each do |_, reportable|
            reportable.collect_reports(words)
          end
        end
      end
    end
  end
end
