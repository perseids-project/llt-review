module LLT
  class Diff::Common::Report
    class Generic
      include Diff::Helpers::Reportable

      attr_reader :reports_to_request

      def initialize(tag, total = 1, reports_to_request = nil)
        @tag = tag
        @total = total
        @reports_to_request = reports_to_request
        @container = {}
      end

      def xml_attributes
        { total: @total, right: @right, wrong: @wrong, unique: @unique }
      end

      def id
        @tag
      end

      def xml_tag
        @tag
      end

      def collect_reports(words)
        # implemented by including classes
      end
    end
  end
end

