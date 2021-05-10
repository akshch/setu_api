class ApiSetu
	include HTTParty

  base_uri AppConfig.maharashtra['endpoint']

  def initialize
    @options =  {
      query: {
        district_id: AppConfig.maharashtra['district']['thane']
      	},
      headers: {
        "Content-Type" => "application/json",
        "Accept" => "application/json",
        "Accept-Language" => "hi_IN",
        "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
      }
    }
  end

  def fetch_by_district(params = nil)
    @options[:query].merge!(params) if params.present?
  	self.class.get("/findByDistrict", @options)
  end

end