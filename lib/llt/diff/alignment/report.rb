module LLT
  class Diff::Alignment
    class Report < Diff::Common::Report
      def report
        {}
      end

      private

      def namespace
        Report
      end
    end
  end
end
