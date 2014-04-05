module LLT
  class Diff::Alignment
    class Comparison < Diff::Common::Comparison
      def report
        @report ||= {}
      end
    end
  end
end
