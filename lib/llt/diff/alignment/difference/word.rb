module LLT
  module Diff::Alignment::Difference
    class Word
      include Diff::Helpers::HashContainable
      include Diff::Helpers::DiffReporter

      xml_tag :word
    end
  end
end

