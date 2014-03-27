module LLT
  class Diff::Alignment < Diff
    require 'llt/diff/alignment/parser'

    #require 'llt/diff/treebank/report'
    #require 'llt/diff/treebank/gold'
    #require 'llt/diff/treebank/reviewable'
    #require 'llt/diff/treebank/comparison'

    require 'llt/diff/alignment/sentence'
    require 'llt/diff/alignment/word'
    require 'llt/diff/alignment/translation'
  end
end

