module LLT
  class Diff::Alignment
    class Sentence
      include Diff::Helpers::HashContainable

      container_alias :words

      attr_accessor :lang1, :lang2
    end
  end
end
