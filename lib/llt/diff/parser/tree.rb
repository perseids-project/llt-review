module LLT
  class Diff::Parser
    # This namespace will get extracted to somewhere else eventually
    class Tree
      require 'llt/diff/parser/tree/helper'
      require 'llt/diff/parser/tree/element'
      require 'llt/diff/parser/tree/root'

      include Helper
    end
  end
end
