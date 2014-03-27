module LLT
  module Diff::Helpers::Parsing::Helper
    def initialize
      @result = Diff::Helpers::Parsing::Result.new
    end

    def result
      @result
    end

    private

    def register_sentence(value)
      @sentence = namespace.const_get(:Sentence).new(value.to_i)
      @result.add(@sentence)
    end

    def register_word(value)
      @word = namespace.const_get(:Word).new(value.to_i)
      @sentence.add(@word)
    end

    def namespace
      # has should be implemented by classes that use this module
      self.class
    end
  end
end
