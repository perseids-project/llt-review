module LLT
  module Review::Alignment::Difference
    class Translation
      include Core::Structures::HashContainable
      include Review::Helpers::ReviewReporter

      xml_tag :translation

      attr_reader :original, :new

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
