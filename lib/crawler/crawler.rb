require "open-uri"

module DamApi
  class Crawler
    attr_accessor :data

    def initialize(begin_date, end_date, dam_id)
      @begin_date = begin_date
      @end_date = end_date
      @dam_id = dam_id
      @domain = "www1.river.go.jp"
    end

    def dat_url
      check_property
      search_url = "http://#{@domain}/cgi-bin/DspDamData.exe?KIND=1&ID=#{@dam_id}&BGNDATE=#{@begin_date}&ENDDATE=#{@end_date}&KAWABOU=NO"
      url = "";
      open(search_url){|f|
        url = "http://" + @domain + f.string.match(/\/dat\/dload\/download\/(.*).dat/)[0]
      }
      url
    end

    def get
      OpenURI.open_uri(dat_url)
    end

    def check_property
      if @begin_date == nil || @end_date == nil || @dam_id == nil || @domain == nil
        raise MissingParameter
      end
    end
  end

  class MissingParameter < Exception; end
end
