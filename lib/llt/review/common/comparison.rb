module LLT
  class Review::Common
    class Comparison
      include Core::Structures::HashContainable

      attr_reader :gold, :reviewable, :unique_differences

      def initialize(gold, reviewable)
        @gold       = gold
        @reviewable = reviewable
        @container  = {}
        @unique_differences = Set.new # set suffices for now, we only need the diff_id's
      end

      def id
        "#{@gold.id}---#{@reviewable.id}"
      end

      # can't use the class method that sets the same, as we have
      # subclasses using this value as well
      def xml_tag
        :comparison
      end

      def xml_attributes
        { gold_id: @gold.id, review_id: @reviewable.id }
      end

      def all_differences
        map do |_, element|
          element.all_differences rescue nil # container might contain other stuff too
        end.flatten.compact
      end

      def compare
        a = @gold.sentences
        b = @reviewable.sentences
        a.each do |sentence_id, sentence|
          difference = sentence.compare(b[sentence_id])
          add(difference) if difference.any?
        end
      end

      # The option to clone gold is here for for performance reasons only.
      # The report stats are calculated right inside the Gold report, which
      # holds all baseline figures. When there is more than one Reviewable
      # present, we need to clone gold, otherwise we would break the calculated
      # values. The easy way out would be to clone gold in any event, but quite
      # often there will be only one item we need to review - a clone is
      # unnecessary then and comes at a cost then - when the treebank file is
      # large it's not only time-expensive, but also adds memory load, which we
      # have enough already of already.
      # Of course this causes pollution of the original Gold instance - for now
      # there's no use case in sight where it would be after this side-effect
      # has been caused.
      def report(clone_gold = false)
        @report ||= begin
          @gold = @gold.clone if clone_gold
          # container includes SentenceReviews, which contain WordsReviews
          r = @gold.report
          r.each_value(&:init_diff)
          each_value do  |d|
            d.report_diff(r, @unique_differences)
          end
          r.each_value(&:count_rights)

          # This looks a bit catastrophic, the reasoning though is:
          # The container includes the sentence diffs - the next element we
          # like to display eventually are the contents of @report, wrapped
          # in an report tag.
          # It might be better to do this otherwise, but this a workaround
          # on short notice.
          # We just add a generic HashContainable structure to the container -
          # other services just as the Assessor can then add their results
          # to the container and we get a nice output in return without
          # coupling llt-diff to llt-assessor.
          report_container = placeholder_container(:report)
          report_container.container.merge!(r)
          add(report_container)
          r
        end
      end

      private

      def placeholder_container(tag)
        Core::Structures::HashContainable::Generic.new(tag)
      end
    end
  end
end
