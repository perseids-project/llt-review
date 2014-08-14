module LLT
  class Review::Treebank
    class Sentence < Review::Common::Sentence
      private

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

      def dummy_word(id)
        w = Word.new(id)
        w.form = "-"
        w.inexistant = true
        w
      end

      def diff_namespace
        Review::Treebank::Difference
      end
    end
  end
end

