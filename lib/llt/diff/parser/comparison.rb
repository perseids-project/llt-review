module LLT
  class Diff::Parser
    class Comparison
      include HashContainable

      xml_tag :comparison

      attr_reader :gold, :reviewable

      def initialize(gold, reviewable)
        @gold       = gold
        @reviewable = reviewable
        @container  = {}
      end

      def id
        "#{@gold.id}---#{@reviewable.id}"
      end

      def xml_attributes
        { gold_id: @gold.id, review_id: @reviewable.id }
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
          # TODO
          # With everything setup, we can now look count errors in each
          # sentence and add these to the total report then.
          # Reportable will have to implement some methods to do that.
          # Unique errors are a bit of a problem. Not sure, it WILL be useful
          # to keep track of errors per sentence - if we would skip that,
          # calculating unique errors wouldn't be a problem at all.
          # Why we want to keep errors per sentence: To report statistics about
          # errors per sentence (e.g. count all errors with one error), at
          # least the author of these lines, LFDM, thinks that's a useful
          # feature to have.
          # We'll see tomorrow!
          @gold.report
        end
      end

      def stats
        "<stats/>"
      end
    end
  end
end
