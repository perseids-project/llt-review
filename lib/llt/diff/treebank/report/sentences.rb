module LLT
  class Diff::Treebank::Report
    class Sentences < Generic
      include Diff::Helpers::Reportable

      def initialize(total = 1)
        super(:sentences, total)
      end
    end
  end
end

