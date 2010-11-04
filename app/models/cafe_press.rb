require 'rexml/document'
require 'open-uri'
class CafePress
  RESULTS_PER_PAGE = 100

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

  def self.get_store_products(cafepress_store_id)
    content = ''
    open("http://open-api.cafepress.com/product.listByStore.cp?v=#{::CAFEPRESS_CONFIG['app_key']}&storeId=#{cafepress_store_id}&page=0&pageSize=#{RESULTS_PER_PAGE}") do |s| content = s.read end
    doc = REXML::Document.new(content)
    store = Store.find_or_create_by_cafepress_store_id(cafepress_store_id)
    store.products.destroy_all
    doc.root.elements.to_a.each do |product|
      store.products.build(:name => product.attributes['name'], :default_caption => product.attributes['defaultCaption'], :cafepress_product_id => product.attributes['id'], :url => product.attributes['marketplaceUri'])
    end
    store.save!
    store
  end
end