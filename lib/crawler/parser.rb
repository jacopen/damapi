module DamApi
  class Parser
    def self.parse(dat)
      data_array = dat.readlines
      9.times do
        data_array.shift
      end

      data = []
      data_array.each do |line|
        @data.push(DamData.create(@dam_id, line.split(",")))
      end

      data
    end
  end
end
