module LLT
  module Review::Treebank::Difference
    class Generic
      include Review::Helpers::HashContainable
      include Review::Helpers::ReviewReporter

      attr_reader :original, :new

      def initialize(item, original, new)
        super(item)
        @original = original
        @new = new
      end

      def xml_tag
        @id
      end

      def xml_attributes
        { original: @original, new: @new, unique: @unique }
      end

      def diff_id
        @diff_id ||= "#{@id}:#{@original}|#{@new}"
      end

      def type
        @tag
      end
    end
  end
end
