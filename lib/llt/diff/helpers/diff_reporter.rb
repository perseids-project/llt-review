module LLT
  module Diff::Helpers
    module DiffReporter
      # While all classes that include DiffReporter also include
      # HashContainable, we cannot include it here, as HashContainable
      # contains ClassMethods that otherwise won't reach the object that need it

      attr_reader :unique

      def initialize(item)
        super(item.id)
        @item = item
      end

      def item
        @item
      end

      def diff_id
        @diff_id ||= "#{id}:#{map { |_, v| v.diff_id }.join('::')}"
      end

      def xml_attributes
        super.merge(unique: @unique)
      end

      def report_diff(report, uniques = nil)
        report_unique = report_unique?(uniques)
        @unique = report_unique ? 1 : 0
        write_to_report(report, report_unique)
        each_value { |v| v.report_diff(report, uniques) }
      end

      private

      def report_unique?(uniques)
        return unless uniques && ! uniques.include?(diff_id)
        !! (uniques << diff_id)
      end

      def write_to_report(report, unique)
      end
    end
  end
end
