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
    end
  end
end
