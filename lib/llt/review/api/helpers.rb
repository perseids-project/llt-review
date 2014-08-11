module LLT
  module Review::Api
    module Helpers
      def origin(el)
        "Publication ##{extracted_id(el.id)} by #{el.sentences.annotators}"
      end

      def combined_extracted_id(comp)
        ids = [comp.gold, comp.reviewable].map { |el| extracted_id(el.id)}.join('-')
        "comp#{ids}"
      end

      def extracted_id(id)
        last = id.split('/').last
        /(.*?)(\.([\w]*?))?$/.match(last)[1]
      end

      def arethusa(rev, gold = nil, chunk = nil, word = nil)
        #path = "http://sosol.perseids.org/tools/arethusa/app/#/perseidslataldt"
        path = "http://85.127.253.84:8081/app/#/review_test"
        path << "?doc=#{rev}&gold=#{gold}"
        if chunk || word
          route << "&chunk=#{chunk}" if chunk
          route << "&w=#{word}" if word
        end
        route
      end

      def to_tooltip(cat, v)
        %{#{cat}: <span class="success">#{v.original}</span> -> <span class="error">#{v.new}</span>}
      end

      def extract_heads(diff, s_id)
        if heads = diff[:head]
          [to_id(s_id, heads.original), to_id(s_id, heads.new)]
        end
      end

      def to_id(s_id, w_id)
        "#{s_id}-#{w_id}"
      end

      def to_percent(total, part)
        ((part.to_f / total) * 100).round(2)
      end
    end
  end
end
