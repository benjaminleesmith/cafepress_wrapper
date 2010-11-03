require 'rexml/document'
require 'open-uri'
class CafePress
  def self.user_token
    ut = UserToken.first
    if ut && 30.minutes.ago < ut.updated_at
      user_token = ut.token
    else
      content = ''
      open("http://open-api.cafepress.com/authentication.getUserToken.cp?v=#{::CAFEPRESS_CONFIG['app_key']}&email=#{::CAFEPRESS_CONFIG['email']}&password=#{::CAFEPRESS_CONFIG['password']}") do |s| content = s.read end
      user_token = REXML::Document.new(content).root.text

      UserToken.set_token(user_token)
    end
    user_token
  end
end