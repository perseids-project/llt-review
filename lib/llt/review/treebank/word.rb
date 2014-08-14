module LLT
  class Review::Treebank
    class Word
      include Core::Structures::HashContainable

      attr_accessor :form, :lemma, :head, :relation
      attr_reader :postag

      Attr = Struct.new(:id, :attribute) do
        def to_s
          attribute
        end

        def report
          @report ||= Report.const_get(id.capitalize).new(attribute)
        end
      end

      %i{ lemma head relation }.each do |type|
        define_method("#{type}=") { |val| add(Attr.new(type, val)) }
      end

      def [](key)
        unless v = super(key)
          v = @container[key] = Attr.new(key, '-')
        end
        v
      end

      def postag=(tag)
        add(Postag.new(tag))
      end

      COMPARABLE_ELEMENTS = %i{ lemma postag head relation }

      def compare(other, diff_container, comparables)
        comparables = COMPARABLE_ELEMENTS unless comparables # default value
        comparables.each do |comparator|
          a, b = [self, other].map { |w| w[comparator].to_s }
          if a != b
            d = diff_container[id] ||= Difference::Word.new(self)
            d.add(new_difference(comparator, a, b))
          end
        end
      end

      private

      def new_difference(comparator, original, new)
        klass = Difference.const_get(comparator.capitalize)
        klass.new(self[comparator], original, new)
      end

      # used when parsers try to check in attributes we are not interested in
      def method_missing(meth, *args, &blk)
        super unless meth =~ /=$/
      end
    end
  end
end
