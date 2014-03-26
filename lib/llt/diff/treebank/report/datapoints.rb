module LLT
  class Diff::Treebank::Report
    class Datapoints < Generic
      include Diff::Helpers::Reportable

      def initialize(total = 1)
        super(:datapoints, total)
      end
    end
  end
end

