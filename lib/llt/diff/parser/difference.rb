module LLT
  class Diff::Parser
    module Difference
      require 'llt/diff/parser/difference/sentence'
      require 'llt/diff/parser/difference/word'
      require 'llt/diff/parser/difference/generic'
      require 'llt/diff/parser/difference/attribute'
      require 'llt/diff/parser/difference/postag'
      require 'llt/diff/parser/difference/datapoint'
      require 'llt/diff/parser/difference/head'
      require 'llt/diff/parser/difference/lemma'
      require 'llt/diff/parser/difference/relation'
    end
  end
end
