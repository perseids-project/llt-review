module LLT
  class Diff::Parser::Report
    class Generic
      include Diff::Parser::Reportable

      attr_reader :reports_to_request

      def initialize(tag, total = 1, reports_to_request = nil)
        @tag = tag
        @total = total
        @reports_to_request = reports_to_request
        @container = {}
      end

      def xml_attributes
        { total: @total }
      end

      def id
        @tag
      end

      def xml_tag
        @tag
      end
    end
  end
end
