module LLT
  class Diff::Parser
    class Sentence
      include HashContainable

      container_alias :words

      def initialize(id)
        super
        @comparable_elements = %i{ lemma postag head relation }
      end

      # currently unsorted
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

      # a multi-step process to avoid unnecessary performance issues
      # the simple attributes can just be counted together, while the more
      # complex ones such as postag need separate merging
      def create_report
        rep = report_hash.each do |category, counter|
          words.each do |_, word|
            res = counter[word.send(category)] ||= counter_hash
            res[:total] += 1
          end
        end
        postag_reports = words.map { |_, w| w.postag.report if w.postag }.compact
        postag = { postag: { total: size }.merge(merge_reports(*postag_reports)) }
        { word: { total: size }, head: { total: size }}.merge(rep).merge(postag)
      end

      TO_COUNT = %i{ relation lemma }
      def report_hash
        Hash[TO_COUNT.map { |c| [c, { total: size } ]}]
      end
    end
  end
end

