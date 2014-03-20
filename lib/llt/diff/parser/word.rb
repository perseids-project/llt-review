module LLT
  class Diff::Parser
    class Word
      include HashContainable

      attr_accessor :form, :lemma, :head, :relation
      attr_reader :postag

      Attr = Struct.new(:attribute, :report_class) do
        def to_s
          attribute
        end

        def report
          Report.const_get(report_class.capitalize).new(attribute)
        end
      end

      %i{ lemma head relation }.each do |attr|
        define_method("#{attr}=") do |val|
          instance_variable_set("@#{attr}", Attr.new(val, attr))
        end
      end

      def postag=(tag)
        @postag = Postag.new(tag)
      end

      def method_missing(meth, *args, &blk)
        super unless meth =~ /=$/
      end
    end
  end
end
