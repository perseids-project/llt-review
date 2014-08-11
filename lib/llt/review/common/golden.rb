module LLT
  class Review::Common
    module Golden
      attr_accessor :sentences

      # Check Comparison#report to learn more
      def clone
        cloned = super
        # need to go to some lengths here, as Parsing::Result objects,
        # which hide behind @sentences, have important inst vars of
        # their own now and are not simply HashContainables
        parse_result = @sentences.clone;
        cloned.replace_with_clone(:sentences, :report)
        parse_result.container.merge!(cloned.sentences)
        cloned.sentences = parse_result
        cloned
      end
    end
  end
end
