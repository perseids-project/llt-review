require 'llt/core/api/helpers'
require 'llt/core/structures/hash_containable'
require 'llt/core/structures/hash_containable/generic'
require "llt/review/version"

module LLT
  # This is pretty much the only messy class this whole gem contains.
  # Do something about it!
  class Review
    require 'llt/review/helpers'

    require 'llt/review/common'
    require 'llt/review/treebank'
    require 'llt/review/alignment'

    include Core::Api::Helpers

    def diff(gold, reviewables, comparables = nil)
      parses = parse_files(Gold: gold, Reviewable: reviewables)

      @gold, @reviewables = parses.partition do |parse_data|
        parse_data.instance_of?(self.class.const_get(:Gold))
      end

      compare(comparables)
      diff_report
      all_diffs
    end

    def report(*uris)
      @reports = parse_files(Report: uris)
      @reports.each(&:report)
      @reports
    end

    def to_xml(type = :diff)
      root_name = "#{root_identifier}-#{type}"
      XML_DECLARATION + wrap_with_tag(root_name, header + send("#{type}_to_xml"))
    end

    def all_diffs
      @all_diffs ||= @reviewables.map do |reviewable|
        reviewable.diff.values
      end.flatten
    end
    alias_method :diffs, :all_diffs
    alias_method :comparisons, :all_diffs

    private

    def diff_report
      if @reviewables.one?
        all_diffs.each(&:report)
      else
        diff_report_with_cloned_reports
      end
    end

    # Check the comment at Comparison#report for more info
    def diff_report_with_cloned_reports
      used_golds = []
      all_diffs.each do |d|
        d.report(to_clone_or_not_to_clone?(used_golds, d.gold.id))
      end
    end

    def to_clone_or_not_to_clone?(used, id)
      used.include?(id) ? true : (used << id; false)
    end

    def compare(comparables = nil)
      @gold.each do |gold|
        @reviewables.each { |reviewable| reviewable.compare(gold, comparables) }
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
          self.class.const_get(klass).new(uri, parse(data))
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
      wrap_with_tag(:comparisons, @reviewables.map(&:to_xml).join)
    end

    def report_to_xml
      wrap_with_tag(:reports, @reports.map(&:to_xml).join)
    end

    def parse(data)
      self.class.const_get(:Parser).new.parse(data)
    end
  end
end
