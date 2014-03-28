require 'spec_helper'

describe LLT::Diff::Alignment do
  let(:alignment) { LLT::Diff::Alignment.new }

  let(:g1) { <<-EOF }
    <aligned-text xmlns="http://alpheios.net/namespaces/aligned-text">
      <language lnum="l1" xml:lang="lat"/>
      <language lnum="l2" xml:lang="eng"/>
      <sentence id="1">
          <wds lnum="l1">
              <w n="1-1">
                  <text>Orgetorix</text>
                  <refs nrefs="1-1"/>
              </w>
              <w n="1-2">
                  <text>rex</text>
                  <refs nrefs="1-3 1-4"/>
              </w>
              <w n="1-3">
                  <text>fuit</text>
                  <refs nrefs="1-2"/>
              </w>
              <w n="1-4">
                  <text>.</text>
                  <refs nrefs="1-5"/>
              </w>
          </wds>
          <wds lnum="l2">
              <w n="1-1">
                  <text>Orgetorix</text>
                  <refs nrefs="1-1"/>
              </w>
              <w n="1-2">
                  <text>was</text>
                  <refs nrefs="1-3"/>
              </w>
              <w n="1-3">
                  <text>a</text>
                  <refs nrefs="1-2"/>
              </w>
              <w n="1-4">
                  <text>king</text>
                  <refs nrefs="1-2"/>
              </w>
              <w n="1-5">
                  <text>.</text>
                  <refs nrefs="1-4"/>
              </w>
          </wds>
      </sentence>
    </aligned-text>
  EOF

  let(:r1) { <<-EOF }
    <aligned-text xmlns="http://alpheios.net/namespaces/aligned-text">
      <language lnum="l1" xml:lang="lat"/>
      <language lnum="l2" xml:lang="eng"/>
      <sentence id="1">
          <wds lnum="l1">
              <w n="1-1">
                  <text>Orgetorix</text>
                  <refs nrefs="1-1"/>
              </w>
              <w n="1-2">
                  <text>rex</text>
                  <refs nrefs="1-3 1-4"/>
              </w>
              <w n="1-3">
                  <text>fuit</text>
                  <refs nrefs="1-2"/>
              </w>
              <w n="1-4">
                  <text>.</text>
                  <refs nrefs="1-5"/>
              </w>
          </wds>
          <wds lnum="l2">
              <w n="1-1">
                  <text>Orgetorix</text>
                  <refs nrefs="1-1"/>
              </w>
              <w n="1-2">
                  <text>was</text>
                  <refs nrefs="1-2"/>
              </w>
              <w n="1-3">
                  <text>a</text>
                  <refs nrefs="1-3"/>
              </w>
              <w n="1-4">
                  <text>king</text>
                  <refs nrefs="1-3"/>
              </w>
              <w n="1-5">
                  <text>.</text>
                  <refs nrefs="1-4"/>
              </w>
          </wds>
      </sentence>
    </aligned-text>
  EOF

  describe "#diff" do
    describe "creates a diff report of a gold and review annotation" do
      it "contains all differences in detail" do
        allow(alignment).to receive(:get_from_uri).with(:uri_for_g1) { g1 }
        allow(alignment).to receive(:get_from_uri).with(:uri_for_r1) { r1 }

        result = alignment.diff([:uri_for_g1], [:uri_for_r1])
        result.should have(1).item         # we had one reviewable annotation
        result[0].should have(1).item      # one sentence with differences
        result[0][1].should have(2).items # and 2 words with differences
      end
    end
  end
end
