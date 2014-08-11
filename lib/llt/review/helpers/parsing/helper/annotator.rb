module LLT
  module Review::Helpers::Parsing::Helper
    class Annotator
      attr_accessor :short, :name, :address, :url

      def complete?
        @short && @name && @address && @url
      end
    end
  end
end
