module LLT
  module Review::Helpers::Parsing::Helper
    class Annotator
      attr_accessor :short, :name, :address, :uri

      def complete?
        @short && @name && @address && @uri
      end

      def name_and_short_to_s
        "#{@name} (#{@short})"
      end
    end
  end
end
