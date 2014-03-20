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
          data = Report::Generic.new(:datapoints, clean_analysis.size)
          clean_analysis.each do |type, val|
            data.add(Report::Postag::Datapoint.new(type, val))
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

      def clean_analysis
        @clean = analysis.reject { |_, v| v == '-' }
      end

      def analysis_to_report
        Hash[
          clean_analysis.map do |type, val|
            [type, { total: 1, val => { total: 1 }}]
          end
        ]
      end

      def datapoints
        POSTAG_SCHEMA.size
      end
    end
  end
end
