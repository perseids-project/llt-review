module LLT
  class Diff::Parser::Report
    class Datapoints < Generic
      include Diff::Parser::NoUniqueReportable

      def initialize(total = 1)
        super(:datapoints, total)
      end
    end
  end
end

