module LLT
  class Diff::Treebank
    class Sentence
      include Diff::Helpers::HashContainable

      container_alias :words

      def report
        @report ||= create_report
      end

      def compare(other)
        diff = Difference::Sentence.new(self)
        words.each { |id, word| word.compare(other[id], diff) }
        diff
      end

      def clone
        cloned = super
        cloned.replace_with_clone(:report)
        cloned
      end

      private

      def create_report
        @report ||= begin
          report_container.each do |_, reportable|
            reportable.collect_reports(words)
          end
        end
      end

      def report_container
        reports = {
          words: nil,
          heads: nil,
          relations: :relation,
          lemmata: :lemma,
        }

        reports.each_with_object({}) do |(tag, requested), hsh|
          hsh[tag] = Report::Generic.new(tag, size, requested)
        end.merge(postags: Report::Postags.new(size))
      end
    end
  end
end

