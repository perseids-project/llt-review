module LLT
  class Review::Alignment
    class Comparison < Review::Common::Comparison
      def report
        @report ||= {}
      end
    end
  end
end
