module LLT
  module Review::Helpers::Parsing::Helper
    class Annotators
      def initialize
        @annotators = []
      end

      def add(annotator)
        @annotators << annotator
      end

      def to_s
        meth = :name_and_short_to_s
        case @annotators.length
        when 0 then "unknown annotators"
        when 1 then @annotators.first.send(meth)
        when 2 then @annotators.map { |a| a.send(meth) }.join(' and ')
        else
          with_punct = @annotators[0..-2].map { |a| a.send(meth) }.join(', ')
          "#{with_punct} and #{@annotators.last.send(meth)}"
        end
      end
    end
  end
end
