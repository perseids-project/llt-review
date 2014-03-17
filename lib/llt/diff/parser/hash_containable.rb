# This shouldn't be here - extract to core and reuse the Containable module

module LLT
  class Diff::Parser
    module HashContainable
      include Enumerable

      attr_reader :container, :id

      def initialize(id = nil)
        @id = id
        @container = {}
      end

      def add(element)
        @container[element.id] = element
      end

      def each(&blk)
        @container.each(&blk)
      end

      def empty?
        @container.empty?
      end

      def [](id)
        @container[id]
      end

      def []=(id, element)
        @container[id] = element
      end

      def size
        @container.size
      end

      def xml_attributes
        { id: id }
      end

      def xml_tag
        self.class.default_xml_tag
      end
      alias_method :default_xml_tag, :xml_tag

      def to_xml
        "<#{xml_tag}#{to_xml_attrs(xml_attributes)}>" +
        container_to_xml +
        "</#{xml_tag}>"
      end

      def container_to_xml
        "#{container.map(&:to_xml).join}"
      end

      private

      def to_xml_attrs(attrs)
        attrs.map { |k, v| %{ #{k}="#{v}"} }.join
      end

      def counter_hash
        Hash.new(0)
      end

      def self.included(klass)
        klass.extend(ClassMethods)
      end

      module ClassMethods
        def container_alias(al)
          alias_method al, :container
          alias_method "no_#{al}?", :empty?
        end

        # Defines the default xml tag used by #to_xml
        def xml_tag(tag)
          @default_xml_tag = tag
        end

        def default_xml_tag
          @default_xml_tag
        end
      end
    end
  end
end
