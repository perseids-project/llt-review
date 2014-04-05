module LLT
  class Review::Common
    class Sentence
      include Review::Helpers::HashContainable

      def words
        @container
      end

      def report
        @report ||= create_report
      end

      def compare(other)
        diff = new_sentence_diff
        words.each { |id, word| word.compare(other[id], diff) }
        diff
      end

      def clone
        cloned = super
        cloned.replace_with_clone(:report)
        cloned
      end

      private

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
