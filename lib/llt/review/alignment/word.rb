module LLT
  class Review::Alignment
    class Word
      include Review::Helpers::HashContainable

      attr_accessor :text

      def to_s
        @text
      end

      def translation
        @translation ||= @container.values.map(&:to_s).join(' ')
      end

      def nrefs
        @container.keys.map(&:to_s).join(' ')
      end

      def compare(other, diff_container)
        unless translation == other.translation
          d = diff_container[id] ||= Difference::Word.new(self)
          d.add(Difference::Translation.new(translation, other.translation))
          d.add(Difference::Nrefs.new(nrefs, other.nrefs))
        end
      end

      def report
        @report ||= begin
          rep = Report::Word.new(@text)
          rep.add(Report::Translation.new(translation))
          rep
        end
      end
    end
  end
end
