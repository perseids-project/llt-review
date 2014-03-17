require "llt/diff/version"

module LLT
  class Diff
    require 'llt/diff/parser'
    require 'llt/diff/parser/difference'
    require 'llt/diff/parser/reviewable'

    def initialize(gold, reviewables)
      @gold, *@reviewables = parse_threaded(gold, reviewables)
      @diff = {}
    end

    def compare
      @reviewables.each_with_index do |reviewable, i|
        @gold.each do |id, sentence|
          if (difference = sentence.compare(reviewable[id])).any?
            @diff[id] = difference
          end
        end

      end
      @diff
    end

    # first item should be the gold standard, followed by
    # one or several annotations to compare
    def parse_threaded(gold, reviewables)
      threads = [gold, reviewables].flatten.map { |el| Thread.new { parse(el) } }
      threads.map { |t| t.join; t.value }
    end

    def parse(data)
      Parser.new.parse(data)
    end
  end
end
