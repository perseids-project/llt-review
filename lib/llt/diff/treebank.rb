module LLT
  class Diff::Treebank < Diff
    require 'llt/diff/treebank/parser'

    require 'llt/diff/treebank/report'
    require 'llt/diff/treebank/gold'
    require 'llt/diff/treebank/reviewable'
    require 'llt/diff/treebank/comparison'

    require 'llt/diff/treebank/sentence'
    require 'llt/diff/treebank/word'
    require 'llt/diff/treebank/postag'

    require 'llt/diff/treebank/difference'

    def parse(data)
      Parser.new.parse(data)
    end
  end
end
