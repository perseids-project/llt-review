require "llt/diff/version"

module LLT
  class Diff
    require 'llt/diff/parser'

    def initialize(gold, review)
      @gold, @review = parse_threaded(gold, review)
    end

    def compare
      true
    end

    def parse_threaded(*elements)
      threads = elements.map { |el| Thread.new { parse(el) } }
      threads.map { |t| t.join; t.value }
    end

    def parse(data)
      Parser.new.parse(data)
    end
  end
end
