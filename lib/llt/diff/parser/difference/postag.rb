module LLT
  module Diff::Parser::Difference
    class Postag < Generic
      def initialize(tag, original, new)
        super
        compute_detailed_differences
      end

      def diff_id
        @diff_id ||= "#{id}:#{map { |_, v| v.diff_id }.join('::')}"
      end

      private

      # copied over right now from Postag until we figure out how to solve this
      # more globally

      POSTAG_SCHEMA = %i{
        part_of_speech person number tense
        mood voice gender case degree
      }

      # we need an instance that responds to #id, otherwise
      # we cannot use Difference::Generic
      Temp = Struct.new(:id)
      def compute_detailed_differences
        @original.each_char.with_index do |a, i|
          b = @new[i]
          add(Generic.new(Temp.new(POSTAG_SCHEMA[i]), a, b)) unless a == b
        end
      end

      def write_to_report(report, unique)
        postags = report[:postags]
        postags.add_wrong(unique)
        postags[item.to_s].add_wrong(unique)
        #when :postag then report[:postags][@item.to_s].add_wrong(unique)
      end

    end
  end
end
