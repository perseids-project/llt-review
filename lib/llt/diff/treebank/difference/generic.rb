module LLT
  module Diff::Treebank::Difference
    class Generic
      include Diff::Helpers::HashContainable
      include Diff::Helpers::DiffReporter

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