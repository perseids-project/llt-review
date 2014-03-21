module LLT
  class Diff::Parser
    class Gold < Report
      attr_reader :sentences

      # Check Comparison#report to learn more
      def cloned_report
        report.each_with_object({}) { |(k, v), hsh| hsh[k] = v.clone }
      end
    end
  end
end

