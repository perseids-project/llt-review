module LLT
  class Diff::Treebank
    class Postag
      attr_reader :id

      def initialize(postag)
        @id = :postag
        @postag = postag
      end

      def to_s
        @postag
      end

      # A little violating... move this to Datapoints
      def report
        @report ||= begin
          # Questionable what the total numbers of datapoints should be.
          # Count empty points as well?
          data = Report::Datapoints.new(@postag.size)
          add_datapoints_container(data)
          data.each_with_index do |(_, container), i|
            rtr = container.reports_to_request
            val = @postag[i]
            next unless val && val != '-'
            container.add(Report::Postag::Datapoint.new(rtr, val))
            container.increment
          end
          data
        end
      end


      # All these constants cannot stay. Hardcoding the meaning of every postag
      # datapoint is a no-go.

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

      CONTAINER_TABLE = PLURALIZED_POSTAG_SCHEMA.zip(POSTAG_SCHEMA)
      def add_datapoints_container(data)
        CONTAINER_TABLE.each do |pl, sg|
          data.add(Report::Generic.new(pl, 0, sg))
        end
      end
    end
  end
end
