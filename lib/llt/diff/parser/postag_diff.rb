module LLT
  class Diff::Parser
    class PostagDiff < GenericDiff
      def initialize(tag, original, new)
        super
        compute_detailed_differences
      end

      private

      # copied over right now from Postag until we figure out how to solve this
      # more globally

      POSTAG_SCHEMA = %i{
        part_of_speech person number tense
        mood voice gender case degree
      }

      def compute_detailed_differences
        @original.each_char.with_index do |a, i|
          b = @new[i]
          add(GenericDiff.new(POSTAG_SCHEMA[i], a, b)) unless a == b
        end
      end
    end
  end
end
