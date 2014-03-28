require 'ox'

module LLT
  class Diff::Alignment::Parser
    class OxHandler < Ox::Sax

      include Diff::Helpers::Parsing::Helper
      include Helper

      def parse(data)
        Ox.sax_parse(self, data)
      end

      def start_element(name)
        if @in_word
          case name
          when :text     then @in_text = true
          when :refs     then @in_refs = true
          end
        else
          case name
          when :w        then @in_word     = true
          when :wds      then @in_wds      = true
          when :sentence then @in_sentence = true
          when :language then @in_language = true
          end
        end
      end

      def end_element(name)
        case name
        when :w        then @in_word = false
        when :text     then @in_text = false
        when :refs     then @in_refs = false
        when :wds      then @in_wds  = false
        when :sentence then @in_sentence = false
        when :language then @in_language = false
        end
      end

      def attr(name, value)
        if @in_word
          case name
          when :n     then register_word(value)
          when :nrefs then register_translation(value) unless @original
          end
        else
          case
          when @in_wds      then set_orig_or_translation(value)
          when @in_sentence then register_sentence(value) if name == :id
          when @in_language then set_languages(name, value)
          end
        end
      end

      def text(value)
        set_text(value)
      end

      private

      def set_languages(name, value)
        return unless name == :"xml:lang"
        @lang1 ? @lang2 = value : @lang1 = value
      end
    end
  end
end
