module LLT
  class Review::Treebank::Report
    class Datapoints < Generic
      include Review::Helpers::Reportable

      def initialize(total = 1)
        super(:datapoints, total)
      end
    end
  end
end

