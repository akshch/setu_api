class Center < ActiveRecord::Base
  has_many :slots

  after_create  :hit_telegram

  class << self
    def send_telegram(id)
      center = Center.find(id)
      center.send_message_to_telegram
    end
  end

  def hit_telegram
    Center.send_telegram(self.id.to_s)
  end

  def send_message_to_telegram
    text = get_text_format
    url = AppConfig['telegram']['endpoint']+AppConfig['telegram']['token']+'/sendMessage'+'?chat_id='+channel+'&text='"#{text}"+'&parse_mode='+AppConfig['telegram']['parseMode']
    response = HTTParty.get(url)
  end
  
  def get_text_format
   'Center Name:'+address+AppConfig['telegram']['newline_without_space']+
   'Pincode:'+pincode.to_s+AppConfig['telegram']['newline_without_space']+
   'Date:'+date.to_s+AppConfig['telegram']['newline_without_space']+
   'Available Capacity:'+available_capacity+AppConfig['telegram']['newline_without_space']+
   'Fee Type:'+fee_type+AppConfig['telegram']['newline_without_space']+
   'Vaccine:'+vaccine
  end
end