require 'spec_helper'

describe LLT::Review::Alignment do
  let(:alignment) { LLT::Review::Alignment.new }

  let(:g1) { <<-EOF }
    <aligned-text xmlns="http://alpheios.net/namespaces/aligned-text">
      <language lnum="L1" xml:lang="lat"/>
      <language lnum="L2" xml:lang="eng"/>
      <sentence id="1">
          <wds lnum="L1">
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
          <wds lnum="L2">
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
      <language lnum="L1" xml:lang="lat"/>
      <language lnum="L2" xml:lang="eng"/>
      <sentence id="1">
          <wds lnum="L1">
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
          <wds lnum="L2">
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
        wrong_words = result[0][1]
        w2, w3 = wrong_words.take(2, 3)

        w2.original.should == 'a king'
        w2.new.should == 'was'

        w3.original.should == 'was'
        w3.new.should == 'a king'
      end

      it "contains a full report section" do
        allow(alignment).to receive(:get_from_uri).with(:uri_for_g1) { g1 }
        allow(alignment).to receive(:get_from_uri).with(:uri_for_r1) { r1 }

        result = alignment.diff([:uri_for_g1], [:uri_for_r1])
        report = result.first.report
        report.should_not be_empty

        sentences = report[:sentences]
        sentences.total.should == 1
        sentences.right.should == 0
        sentences.wrong.should == 1
        sentences.unique.should == 1

        words = report[:words]
        words.total.should == 4
        words.right.should == 2
        words.wrong.should == 2
        words.unique.should == 2

        rex = words['rex']
        rex.total.should == 1
        rex.right.should == 0
        rex.wrong.should == 1
        rex.unique.should == 1

        fuit = words['fuit']
        fuit.total.should == 1
        fuit.right.should == 0
        fuit.wrong.should == 1
        fuit.unique.should == 1
      end
    end
  end

  let(:rep) { <<-EOF }
    <aligned-text xmlns="http://alpheios.net/namespaces/aligned-text">
        <language lnum="L1" xml:lang="lat"/>
        <language lnum="L2" xml:lang="eng"/>
        <sentence id="1">
            <wds lnum="L1">
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
                    <text>,</text>
                    <refs nrefs="1-5"/>
                </w>
                <w n="1-5">
                    <text>rex</text>
                    <refs nrefs="1-6 1-7"/>
                </w>
                <w n="1-6">
                    <text>.</text>
                    <refs nrefs="1-8"/>
                </w>
            </wds>
            <wds lnum="L2">
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
                    <text>,</text>
                    <refs nrefs="1-4"/>
                </w>
                <w n="1-6">
                    <text>a</text>
                    <refs nrefs="1-5"/>
                </w>
                <w n="1-7">
                    <text>king</text>
                    <refs nrefs="1-5"/>
                </w>
                <w n="1-8">
                    <text>.</text>
                    <refs nrefs="1-6"/>
                </w>
            </wds>
        </sentence>
    </aligned-text>
  EOF

  describe "#report" do
    it "reports about how every word was translated" do
      allow(alignment).to receive(:get_from_uri).with(:uri_for_rep) { rep }
      result = alignment.report(:uri_for_rep)
      result.should have(1).item
      report = result.first
      report[:sentences].total.should == 1
      words = report[:words]
      words.total.should == 6
      rex = words['rex']
      rex.total.should == 2
      rex['a king'].total.should == 2
    end
  end
end
