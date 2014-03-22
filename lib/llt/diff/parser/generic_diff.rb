module LLT
  class Diff::Parser
    class GenericDiff
      include HashContainable

      attr_reader :original, :new

      def initialize(tag, original, new)
        super("#{original}---#{new}")
        @tag = tag
        @original = original
        @new = new
      end

      def xml_tag
        @tag
      end

      def xml_attributes
        { original: @original, new: @new, unique: @unique }
      end

      def diff_id
        @id
      end
    end
  end
end
