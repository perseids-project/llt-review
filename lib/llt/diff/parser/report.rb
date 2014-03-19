module LLT
  class Diff::Parser
    class Report
      include HashContainable

      xml_tag :report

      attr_reader :sentences

      def initialize(id, sentences)
        super(id)
        @sentences = sentences
        @counts    = {}
      end

      def counts
        return @counts if @counts.any?
        @counts[:sentences] = { total: @sentences.count }
        full_report = merge_reports(*@sentences.map { |_, s| s.report })
        @counts.merge!(sort_report(full_report))
      end
    end
  end
end
