require File.join(File.dirname(__FILE__), '..', 'spec_helper')

require 'crawler/crawler'

describe "Crawler" do
  describe ".check_property" do
    before :each do
      @crawler = DamApi::Crawler.new("hoge", "fuga", nil)
    end

    it "should raise if parameters are nil" do
      proc{ @crawler.check_property }.should raise_error
    end
  end
end
