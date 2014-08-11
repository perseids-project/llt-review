module LLT
  module Review::Helpers::Parsing::Helper
    class Annotator
      attr_accessor :short, :name, :address, :url

      def complete?
        @short && @name && @address && @url
      end

      def name_and_short_to_s
        "#{@name} (#{@short})"
      end
    end
  end
end
