require "./lib/DamParser"
require "./lib/Record"
require "rubygems"
require "active_support"

#ActiveRecord::Base.establish_connection(
#  :adapter  => "sqlite3",
#  :database => "./lib/dam.sqlite3",
#  :timeout  => 5000
#)
#
##データのクロール
#dam = DamDataCrawler.new("20110301", "20110305", "1368080700010")
#dam.generate_dam_data
#
##DBに記録
#DamDataRecorder.record(dam.data)

date = Date.parse("2004-10-1")
while(date != Date.parse("2011-03-01")) do
  date = date.next_month
  start = date.beginning_of_month.strftime("%Y%m%d")
  stop =  date.end_of_month.strftime("%Y%m%d")
end
