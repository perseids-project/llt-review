module LLT
  class Diff::Alignment < Diff
    require 'llt/diff/alignment/parser'

    require 'llt/diff/alignment/report'
    require 'llt/diff/alignment/gold'
    require 'llt/diff/alignment/reviewable'
    require 'llt/diff/alignment/comparison'

    require 'llt/diff/alignment/sentence'
    require 'llt/diff/alignment/word'
    require 'llt/diff/alignment/translation'

    private

    def root_identifier
      'alignment'
    end

    def compare
    end

    def diff_report
    end
  end
end

