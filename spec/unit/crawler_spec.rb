require File.join(File.dirname(__FILE__), '..', 'spec_helper')

require 'crawler/crawler'

describe "Crawler" do
  before :all do
    @crawler = DamApi::Crawler.new
  end

  context "invalid condition(parameters are nil)" do
    it "should raise " do
      expect { @crawler.conditions(dam_id: "hoge", begin_date: "fuga", end_date: nil)}.to raise_error
    end
  end

  context "valid condition" do
    before :all do
      @condition = {dam_id: "1368080700010", begin_date: "20140123", end_date: "20140124"}
    end

    it "should raise " do
      expect { @crawler.conditions(@condition)}.not_to raise_error
    end

    it "should return dat url" do
      expect( @crawler.dat_url).to match(/dat\/dload\/download\//)
    end
  end
end
