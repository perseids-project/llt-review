module LLT
  class Diff::Treebank
    class Parser
      require 'llt/diff/treebank/parser/helper'
      autoload :NokogiriHandler, 'llt/diff/treebank/parser/nokogiri_handler'
      autoload :OxHandler,       'llt/diff/treebank/parser/ox_handler'

      include Diff::Helpers::Parsing
    end
  end
end


