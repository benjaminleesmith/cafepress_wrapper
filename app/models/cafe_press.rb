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
      open("http://open-api.cafepress.com/authentication.getUserToken.cp?appKey=#{::CAFEPRESS_CONFIG['app_key']}&email=#{::CAFEPRESS_CONFIG['email']}&password=#{::CAFEPRESS_CONFIG['password']}") do |s| content = s.read end
      user_token = REXML::Document.new(content).root.text

      UserToken.set_token(user_token)
    end
    user_token
  end

  def self.load_store_data(cafepress_store_id)
    CafePress.get_store(cafepress_store_id)
    store = CafePress.get_store_products(cafepress_store_id)
    design_url = CafePress.get_design_url(store.products.first.cafepress_design_id)
    store.update_attributes(:cafepress_design_url => design_url)

    if store.products.first.cafepress_back_design_id
      design_url = CafePress.get_design_url(store.products.first.cafepress_back_design_id)
      store.update_attributes(:cafepress_back_design_url => design_url)
    end
  end

  def self.get_store_products(cafepress_store_id)
    content = ''
    open("http://open-api.cafepress.com/product.listByStore.cp?v=3&appKey=#{::CAFEPRESS_CONFIG['app_key']}&storeId=#{cafepress_store_id}&page=0&pageSize=#{RESULTS_PER_PAGE}") do |s| content = s.read end
    doc = REXML::Document.new(content)
    store = Store.find_or_create_by_cafepress_store_id(cafepress_store_id)
    store.products.destroy_all
    doc.root.elements.to_a.each do |product|
      begin
        cafepress_back_design_id = product.get_elements("mediaConfiguration[@perspectives='Back']").first.attributes['designId']
      rescue
        cafepress_back_design_id = nil
      end
      
      store.products.build(
        :name => product.attributes['name'],
        :default_caption => product.attributes['defaultCaption'],
        :cafepress_product_id => product.attributes['id'],
        :url => product.attributes['marketplaceUri'],
        :cafepress_design_id => product.get_elements("mediaConfiguration[@perspectives='Front']").first.attributes['designId'],
        :cafepress_back_design_id => cafepress_back_design_id
      )
    end
    store.save!
    store
  end

  def self.get_design_url(cafepress_design_id)
    content = ''
    open("http://open-api.cafepress.com/design.find.cp?v=3&appKey=#{::CAFEPRESS_CONFIG['app_key']}&id=#{cafepress_design_id}") do |s| content = s.read end
    doc = REXML::Document.new(content)
    doc.root.attributes['mediaUrl']
  end

  def self.get_store(cafepress_store_id)
    content = ''
    open("http://open-api.cafepress.com/store.findByStoreId.cp?v=3&appKey=#{::CAFEPRESS_CONFIG['app_key']}&storeId=#{cafepress_store_id}") do |s| content = s.read end
    doc = REXML::Document.new(content)
    description = doc.root.attributes['description']

    store = Store.find_or_create_by_cafepress_store_id(cafepress_store_id)
    store.description = description
    store.save!
    store
  end
end