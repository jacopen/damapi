require "./lib/DamParser"
require "./lib/Record"

ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => "./lib/dam.sqlite3",
  :timeout  => 5000
)

#データのクロール
dam = DamDataCrawler.new("20110301", "20110305", "1368080700010")
dam.generate_dam_data

#DBに記録
DamDataRecorder.record(dam.data)