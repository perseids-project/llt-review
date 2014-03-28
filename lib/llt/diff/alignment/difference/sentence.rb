module LLT
  module Diff::Alignment::Difference
    class Sentence
      include Diff::Helpers::HashContainable
      include Diff::Helpers::DiffReporter

      xml_tag :sentence
    end
  end
end
