module LLT
  class Diff::Alignment
    class Parser
      require 'llt/diff/alignment/parser/helper'

      autoload :NokogiriHandler, 'llt/diff/alignment/parser/nokogiri_handler'
      autoload :OxHandler,       'llt/diff/alignment/parser/ox_handler'

      include Diff::Helpers::Parsing
    end
  end
end

