require 'llt/core/api/helpers'
require "llt/diff/version"

module LLT
  class Diff
    require 'llt/diff/parser'

    include Core::Api::Helpers

    def diff(gold, reviewables)
      parses = parse_files(Gold: gold, Reviewable: reviewables)

      @gold, @reviewables = parses.partition do |parse_data|
        parse_data.instance_of?(Parser::Gold)
      end

      compare
      all_diffs
    end

    def to_xml(type = :xml)
      XML_DECLARATION + wrap_with_tag('doc', header + send("#{type}_to_xml"))
    end

    private

    def all_diffs
      @reviewables.map { |reviewable| reviewable.diff.values }.flatten
    end

    def compare
      @gold.each do |gold|
        @reviewables.each { |reviewable| reviewable.compare(gold) }
      end
    end

    def parse_files(files)
      to_parse = files.flat_map { |klass, uris| uris.map { |uri| [klass, uri] } }
      parse_threaded(to_parse)
    end

    def parse_threaded(uris_with_classes)
      threads = uris_with_classes.map do |klass, uri|
        Thread.new do
          data = get_from_uri(uri)
          Parser.const_get(klass).new(uri, parse(data))
        end
      end
      threads.map { |t| t.join; t.value }
    end

    def header
      wrap_with_tag('files', header_files.map(&:xml_heading).join)
    end

    def header_files
      [@gold, @reviewables, @reports].flatten.compact
    end

    def wrap_with_tag(tag, content)
      "<#{tag}>" +
        content +
      "</#{tag}>"
    end

    def diff_to_xml
      @reviewables.map(&:to_xml).join
    end

    def parse(data)
      Parser.new.parse(data)
    end
  end
end
