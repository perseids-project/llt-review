module LLT
  module Diff::Parser::Difference
    class Datapoint < Generic
      def initialize(id, original, new)
        @id = id
        @original = original
        @new = new
        @container = {}
      end

      def write_to_report(report, unique)
        container = report[:postags][:datapoints]
        container.add_wrong(unique)
        container[category][@original].add_wrong(unique)
      end

      private

      def category
        if @id.match(/_/)
          @id.to_s.sub(/(.*?)_(.*)/, '\1' + 's_' + '\2')
        else
          "#{@id}s"
        end.to_sym
      end
    end
  end
end
