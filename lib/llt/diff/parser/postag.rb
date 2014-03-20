module LLT
  class Diff::Parser
    class Postag
      def initialize(postag)
        @postag = postag
      end

      def to_s
        @postag
      end

      def report
        @report ||= begin
          # Questionable what the total numbers of datapoints should be.
          # Count empty points as well?
          data = Report::Generic.new(:datapoints, analysis.size)
          add_datapoints_container(data)
          data.each do |_, container|
            rtr = container.reports_to_request
            next unless (val = analysis[rtr]) && val != '-'
            container.add(Report::Postag::Datapoint.new(rtr, val))
            container.increment
          end
          data
        end
      end

      POSTAG_SCHEMA = %i{
        part_of_speech person number tense
        mood voice gender case degree
      }
      def analysis
        @analysis ||= begin
          Hash[POSTAG_SCHEMA.zip(@postag.each_char)]
        end
      end

      def datapoints
        POSTAG_SCHEMA.size
      end

      PLURALIZED_POSTAG_SCHEMA = %i{
        parts_of_speech persons numbers tenses
        moods voices genders cases degrees
      }
      def add_datapoints_container(data)
        PLURALIZED_POSTAG_SCHEMA.zip(POSTAG_SCHEMA).each do |pl, sg|
          data.add(Report::Generic.new(pl, 0, sg))
        end
      end
    end
  end
end
