module LLT
  class Diff::Parser
    class WordDiff
      require 'llt/diff/parser/postag_diff'

      include HashContainable

      attr_reader :lemma, :head, :relation, :postag

      xml_tag :word

      Attr = Struct.new(:original, :new)
      %i{ lemma head relation }.each do |attr|
        define_method("#{attr}=") do |values|
          instance_variable_set("@#{attr}", Attr.new(*values))
        end
      end

      def postag=(data)
        @postag = PostagDiff.new(*data)
      end

      def container_to_xml
        grouped_differences.map { |type, val| "<#{type}#{to_xml_attrs(val)}/>" }.join
      end

      DIFFERENCES = %i{ lemma postag head relation }
      def grouped_differences
        res = { original: {}, new: {} }
        DIFFERENCES.each do |var|
          if diff = send(var)
            res[:original][var] = diff.original
            res[:new][var]      = diff.new
          end
        end
        res
      end
    end
  end
end

