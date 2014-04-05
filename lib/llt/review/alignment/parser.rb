module LLT
  class Review::Alignment
    class Parser
      require 'llt/review/alignment/parser/helper'

      autoload :NokogiriHandler, 'llt/review/alignment/parser/nokogiri_handler'
      autoload :OxHandler,       'llt/review/alignment/parser/ox_handler'

      include Review::Helpers::Parsing
    end
  end
end

