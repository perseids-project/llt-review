module LLT
  class Diff::Parser
    class Report
      include Reportable

      attr_reader :sentences

      def initialize(id, sentences)
        super(id)
        @sentences = sentences
      end

      def report
        @report ||= begin
          add_report_container
          @sentences.map { |_, s| s.report }.each do |rep|
            rep.each { |_, r| add(r) }
          end
          @container
        end

      end

      def xml_attributes
        { id: @id }
      end

      private

      def add_report_container
        add(Generic.new(:sentences, @sentences.count))
      end
    end
  end
end
