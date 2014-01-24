require "open-uri"

module DamApi
  class Crawler

    def conditions(params)
      @dam_id       = params[:dam_id]
      @begin_date   = params[:begin_date]
      @end_date     = params[:end_date]
      check_property
    end

    def dat_url
      check_property
      search_url = "http://www1.river.go.jp/cgi-bin/DspDamData.exe?KIND=1&ID=#{@dam_id}&BGNDATE=#{@begin_date}&ENDDATE=#{@end_date}&KAWABOU=NO"
      url = "";
      open(search_url){|f|
        url = "http://www1.river.go.jp" + f.string.match(/\/dat\/dload\/download\/(.*).dat/)[0]
      }
      url
    end

    def get
      OpenURI.open_uri(dat_url)
    end

    private
    def check_property
      if @begin_date == nil || @end_date == nil || @dam_id == nil
        raise MissingParameterException
      end
    end
  end

  class MissingParameterException < Exception; end
end
