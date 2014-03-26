module LLT
  class Diff::Treebank
    class Gold < Report
      attr_reader :sentences

      # Check Comparison#report to learn more
      def clone
        cloned = super
        cloned.replace_with_clone(:sentences, :report)
        cloned
      end
    end
  end
end

