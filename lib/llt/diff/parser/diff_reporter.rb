module LLT
  class Diff::Parser
    module DiffReporter
      # While all classes that include DiffReporter also include
      # HashContainable, we cannot include it here, as HashContainable
      # contains ClassMethods that otherwise won't reach the object that need it
      def diff_id
        @diff_id ||= "#{id}:#{map { |_, v| v.diff_id }.join('::')}"
      end
    end
  end
end
