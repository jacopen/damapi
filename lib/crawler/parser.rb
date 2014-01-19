require "open-uri"

class DamDataParser
  url_template = "http://www1.river.go.jp/cgi-bin/DspDamData.exe?KIND=1&ID=1368080700010&BGNDATE=20110301&ENDDATE=20110330&KAWABOU=NO"
end

class DamDataCrawler
  attr_accessor :data
  
  def initialize(_begin_date, _end_date, _dam_id)
    @begin_date = _begin_date
    @end_date = _end_date
    @dam_id = _dam_id
    @domain = "www1.river.go.jp"
  end

  def search_url
    check_property
    return "http://#{@domain}/cgi-bin/DspDamData.exe?KIND=1&ID=#{@dam_id}&BGNDATE=#{@begin_date}&ENDDATE=#{@end_date}&KAWABOU=NO"
  end

  def dat_url
    check_property
    url = "";
    open(search_url){|f|
      url = "http://" + @domain + f.string.match(/\/dat\/dload\/download\/(.*).dat/)[0]
    }
    return url
  end

  def get
    @get_value = OpenURI.open_uri(dat_url)
  end

  def generate_dam_data
    get
    data_array = @get_value.readlines
    9.times do
      data_array.shift
    end
    @data = []
    data_array.each do |line|
      @data.push(DamData.create(@dam_id, line.split(",")))
    end
  end

  def check_property
    if @begin_date == nil || @end_date == nil || @dam_id == nil || @domain == nil
      raise
    end
  end
end

class DamData
  attr_accessor :time, :precipitation, :stored, :income, :outbound, :stored_percentage, :dam_id
  def self.create(dam_id, arr)
    dam_data = DamData.new
    dam_data.dam_id = dam_id
    dam_data.time = DateTime.parse(arr[0] + " " + arr[1])
    dam_data.precipitation = arr[2]
    dam_data.stored = arr[4]
    dam_data.income = arr[6]
    dam_data.outbound = arr[8]
    dam_data.stored_percentage = arr[10]
    return dam_data
  end
end

class DamDataRecorder
  def self.record(dam_data)
    dam_data.each do |line|
      record = Record.new
      record.dam_id = line.dam_id
      record.time = line.time
      record.precipitation = line.precipitation
      record.stored = line.stored
      record.stored_type = nil
      record.income = line.income
      record.income_type = nil
      record.outbound = line.outbound
      record.outbound_type = nil
      record.stored_percentage = line.stored_percentage
      record.stored_percentage_type = nil
      log = Record.find(:all, :conditions => {:dam_id => line.dam_id, :time => line.time})
      if(log.length == 0)
        record.save
      end
    end
  end
end
