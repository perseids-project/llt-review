module LLT
  class Diff::Parser
    class Report
      include HashContainable

      xml_tag :report

      attr_reader :sentences

      def initialize(id, sentences)
        super(id)
        @sentences = sentences
      end

      def report
        @report ||= begin
          rep = { sentence: { total: @sentences.count } }
          full_report = merge_reports(*@sentences.map { |_, s| s.report })
          rep.merge(full_report)
        end
      end

      def container_to_xml
        hash_to_xml(report)
      end
    end
  end
end
