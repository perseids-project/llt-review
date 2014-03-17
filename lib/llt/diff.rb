require "llt/diff/version"

module LLT
  class Diff
    require 'llt/diff/parser'

    def initialize(gold, reviewables)
      @gold, @reviewables = parse_threaded(gold, reviewables)
      @diff = {}
    end

    def compare
      @reviewables.each { |reviewable| reviewable.compare(@gold) }
    end

    # first item should be the gold standard, followed by
    # one or several annotations to compare
    def parse_threaded(gold, reviewables)
      threads = [gold, reviewables].flatten.map { |el| Thread.new { parse(el) } }
      results = threads.map { |t| t.join; t.value }
      [results.shift, results.map { |result| Parser::Reviewable.new(nil, result) }]
    end

    def parse(data)
      Parser.new.parse(data)
    end
  end
end
