module LLT
  class Diff::Parser
    class Difference
      include HashContainable

      attr_accessor :lemma, :postag, :head, :relation

      def to_xml
        as_xml
      end

      def as_xml
        grouped_differences.map { |type, val| "<#{type} #{to_xml_attrs(val)}/>" }.join
      end

      DIFFERENCES = %i{ lemma postag head relation }
      def grouped_differences
        res = { original: {}, new: {} }
        DIFFERENCES.each do |var|
          if diff = send(var)
            res[:original] = { var => diff.first }
            res[:new]      = { var => diff.last }
          end
        end
        res
      end
    end
  end
end

