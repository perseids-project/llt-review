module LLT
  class Review::Alignment < Review
    require 'llt/review/alignment/parser'

    require 'llt/review/alignment/report'
    require 'llt/review/alignment/gold'
    require 'llt/review/alignment/reviewable'
    require 'llt/review/alignment/comparison'

    require 'llt/review/alignment/sentence'
    require 'llt/review/alignment/word'
    require 'llt/review/alignment/translation'

    require 'llt/review/alignment/difference'

    private

    def root_identifier
      'alignment'
    end
  end
end

