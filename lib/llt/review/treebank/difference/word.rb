module LLT
  module Review::Treebank::Difference
    class Word < Review::Common::Difference::Word
      attr_reader :lemma, :head, :relation, :postag
    end
  end
end

