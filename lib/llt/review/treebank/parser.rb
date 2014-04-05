module LLT
  class Review::Treebank
    class Parser
      require 'llt/review/treebank/parser/helper'
      autoload :NokogiriHandler, 'llt/review/treebank/parser/nokogiri_handler'
      autoload :OxHandler,       'llt/review/treebank/parser/ox_handler'

      include Review::Helpers::Parsing
    end
  end
end


