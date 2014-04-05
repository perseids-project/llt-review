module LLT
  module Review::Common::Difference
    class Word
      include Core::Structures::HashContainable
      include Review::Helpers::ReviewReporter

      def xml_tag
        :word
      end

      def diff
        @container
      end

      private

      def write_to_report(report, unique)
        report[:words].add_wrong(unique)
      end
    end
  end
end
