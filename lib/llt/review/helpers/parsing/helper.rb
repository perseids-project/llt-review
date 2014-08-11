module LLT
  module Review::Helpers::Parsing::Helper
    require 'llt/review/helpers/parsing/helper/for_nokogiri'
    require 'llt/review/helpers/parsing/helper/annotators'
    require 'llt/review/helpers/parsing/helper/annotator'

    def initialize
      @result = Review::Helpers::Parsing::Result.new
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

    def register_format(format)
      @result.format = format
    end

    def register_language(language)
      @result.lang = language
    end

    def namespace
      # has should be implemented by classes that use this module
      self.class
    end
  end
end
