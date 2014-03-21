module LLT
  class Diff::Parser
    class Gold < Report
      attr_reader :sentences

      # Check Comparison#report to learn more
      def cloned_report
        hash_with_cloned_values(report)
      end
    end
  end
end

