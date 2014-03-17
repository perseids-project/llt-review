require 'llt/core/api/helpers'
require "llt/diff/version"

module LLT
  class Diff
    require 'llt/diff/parser'

    include Core::Api::Helpers

    def diff(gold, reviewables)
      parse_files(gold, reviewables)
      compare
      all_diffs
    end

    def all_diffs
      @reviewables.map { |reviewable| reviewable.diff.values }.flatten
    end

    def compare
      @gold.each do |gold|
        @reviewables.each { |reviewable| reviewable.compare(gold) }
      end
    end

    def parse_files(gold, reviewables)
      to_parse = gold.map { |uri| [:Gold, uri] } + reviewables.map { |uri| [:Reviewable, uri] }
      @gold, @reviewables = parse_threaded(to_parse).partition do |parse_data|
        parse_data.instance_of?(Parser::Gold)
      end
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

    def to_xml
      XML_DECLARATION + wrap_with_tag('doc', header + diff_to_xml)
    end

    def header
      wrap_with_tag('files', (@gold + @reviewables).map(&:xml_heading).join)
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
