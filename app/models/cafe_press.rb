class CafePress
  def self.user_token
    require 'open-uri'
    content = ''
    open("http://open-api.cafepress.com/authentication.getUserToken.cp?v=#{::CAFEPRESS_CONFIG['app_key']}&email=#{::CAFEPRESS_CONFIG['email']}&password=#{::CAFEPRESS_CONFIG['password']}") do |s| content = s.read end
    puts content
  end
end