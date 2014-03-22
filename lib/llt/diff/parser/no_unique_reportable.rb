module LLT
  class Diff::Parser
    module NoUniqueReportable
      include Reportable

      def init_diff
        super
        @unique = nil
      end

      def add_wrong(*)
        @wrong += 1
      end
    end
  end
end

