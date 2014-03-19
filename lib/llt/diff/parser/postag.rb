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
          { datapoints: { total: datapoints }.merge(analysis_to_report)}
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
