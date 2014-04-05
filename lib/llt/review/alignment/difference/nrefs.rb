module LLT
  module Review::Alignment::Difference

    # This whole class could arguably deleted, not sure there is any need for it

    class Nrefs
      include Review::Helpers::HashContainable
      include Review::Helpers::ReviewReporter

      xml_tag :nrefs

      def initialize(original, new)
        @id = id
        @original = original
        @new = new
        @container = {}
      end

      def id
        xml_tag
      end

      def xml_attributes
        { original: @original, new: @new, unique: @unique }
      end
    end
  end
end

