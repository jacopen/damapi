require File.join(File.dirname(__FILE__), '..', 'spec_helper')

require 'crawler/crawler'

describe "Crawler" do
  include WebMock::API
  before :all do
    @crawler = DamApi::Crawler.new
  end

  context "invalid condition(parameters are nil)" do
    it "should raise " do
      expect { @crawler.conditions(dam_id: "hoge", begin_date: "fuga", end_date: nil)}.to raise_error
    end
  end

  context "valid condition" do
    before do
      @condition = {dam_id: "1368080700010", begin_date: "20140123", end_date: "20140124"}
      stub_request(:get, "http://www1.river.go.jp/cgi-bin/DspDamData.exe?BGNDATE=20140123&ENDDATE=20140124&ID=1368080700010&KAWABOU=NO&KIND=1").
        to_return(:status => 200, :body => File.read(webmock_asset("search.html")))
    end

    it "should raise " do
      expect { @crawler.conditions(@condition)}.not_to raise_error
    end

    it "should return dat url" do
      expect( @crawler.dat_url).to match(/dat\/dload\/download\//)
    end
  end
end

# http://www1.river.go.jp/cgi-bin/DspDamData.exe?BGNDATE=20140123&ENDDATE=20140124&ID=1368080700010&KAWABOU=NO&KIND=1
