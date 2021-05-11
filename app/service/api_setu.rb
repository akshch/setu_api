class ApiSetu
	include HTTParty

  base_uri AppConfig.maharashtra['endpoint']

  def initialize
    @options =  {
      query: {},
      headers: {
        "Content-Type" => "application/json",
        "Accept" => "application/json",
        "Accept-Language" => "hi_IN",
        "User-Agent" => 'User-Agent' 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'
      }
    }
  end

  def fetch_by_district(params = nil)
    @options[:query].merge!(params) if params.present?
  	self.class.get("/findByDistrict", @options)
  end

  def fetch_by_pincode(params = nil)
    @options[:query].merge!(params) if params.present?
    self.class.get("/findByPin", @options)
  end

end