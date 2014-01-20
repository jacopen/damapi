module DamApi
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
end
