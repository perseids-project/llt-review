module LLT
  class Diff::Parser
    class Gold < Report
      xml_tag :gold

      attr_reader :sentences
    end
  end
end

