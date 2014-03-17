require "llt/diff/version"

module LLT
  class Diff
    require 'llt/diff/parser'
    require 'llt/diff/difference'

    def initialize(gold, review)
      @gold, @review = parse_threaded(gold, review)
      @diff = {}
    end

    def compare
      @gold.each do |id, sentence|
        if (difference = sentence.compare(@review[id])).any?
          @diff[id] = difference
        end
      end

      @diff
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
