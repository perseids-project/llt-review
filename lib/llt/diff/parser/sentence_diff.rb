module LLT
  class Diff::Parser
    class SentenceDiff
      include HashContainable
      include DiffReporter

      container_alias :diff
      xml_tag :sentence

      def diff_id
        @diff_id ||= "#{id}:#{map { |_, v| v.diff_id }.join('::')}"
      end
    end
  end
end
