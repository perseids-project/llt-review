module LLT
  module Diff::Treebank::Difference
    class Word < Diff::Common::Difference::Word
      attr_reader :lemma, :head, :relation, :postag
    end
  end
end

