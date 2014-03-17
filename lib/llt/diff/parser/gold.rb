module LLT
  class Diff::Parser
    class Gold
      include HashContainable

      xml_tag :gold

      attr_reader :sentences

      def initialize(id, sentences)
        super(id)
        @sentences = sentences
      end
    end
  end
end

