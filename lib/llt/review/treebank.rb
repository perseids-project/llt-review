module LLT
  class Review::Treebank < Review
    require 'llt/review/treebank/parser'

    require 'llt/review/treebank/report'
    require 'llt/review/treebank/gold'
    require 'llt/review/treebank/reviewable'
    require 'llt/review/treebank/comparison'

    require 'llt/review/treebank/sentence'
    require 'llt/review/treebank/word'
    require 'llt/review/treebank/postag'

    require 'llt/review/treebank/difference'

    private

    def root_identifier
      'treebank'
    end
  end
end
