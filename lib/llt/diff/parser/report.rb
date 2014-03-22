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

      def collect_singlethreaded
        @sentences.map { |_, s| s.report }.each do |rep|
          rep.each { |_, r| add(r) }
        end
      end

      def collect_multithreaded
        slice_size = @sentences.size / 4
        threads = []
        @sentences.each_slice(slice_size) do |slice|
          temp_container = Report.new(nil, {})
          threads << Thread.new do
            slice.map { |_, s| s.report }.each do |rep|
              rep.each { |_, r| temp_container.add(r) }
            end
            temp_container
          end
        end
        temps = threads.flat_map { |t| t.join; t.value }
        temps.each { |temp| temp.each { |_, r| add(r) }}
      end

      def xml_attributes
        { id: @id }
      end

      private

      def add_report_container
        add(Sentences.new(@sentences.count))
      end
    end
  end
end
