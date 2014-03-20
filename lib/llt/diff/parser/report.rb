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
          if RUBY_ENGINE == 'jruby'
            collect_multithreaded
          else
            collect_singlethreaded
          end
          @container.each { |_, rep| rep.sort! }
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
