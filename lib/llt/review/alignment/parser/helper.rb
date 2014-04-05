module LLT
  class Review::Alignment::Parser
    module Helper
      def namespace
        Review::Alignment
      end

      private

      def register_sentence(value)
        super
        @sentence.lang1 = @lang1
        @sentence.lang2 = @lang2
      end

      def register_word(value)
        value = stripped_id(value)
        return super if @original
        @translation = namespace.const_get(:Translation).new(value.to_i)
      end

      def register_translation(refs)
        refs.split.map { |ref| stripped_id(ref).to_i }.each do |ref|
          @sentence[ref].add(@translation)
        end
      end

      def stripped_id(value)
        value.slice(/(?<=-).*/)
      end

      def set_orig_or_translation(value)
        @original = value == "L1"
      end

      def set_text(value)
        return unless @in_text
        target = @original ? @word : @translation
        target.text = value
      end
    end
  end
end
