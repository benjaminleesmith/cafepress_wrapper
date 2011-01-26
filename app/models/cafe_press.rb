# Copyright 2010 Benjamin Lee Smith <benjamin.lee.smith@gmail.com>
#
# This file is part of CafePress Wrapper.
# CafePress Wrapper is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# CafePress Wrapper is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with CafePress Wrapper.  If not, see <http://www.gnu.org/licenses/>.

require 'rexml/document'
require 'open-uri'
class CafePress
  RESULTS_PER_PAGE = 100

  def self.user_token(app_key = ENV['cp_app_key'], email = ENV['cp_email'], password = ENV['cp_password'])
    content = ''
    open("http://open-api.cafepress.com/authentication.getUserToken.cp?appKey=#{app_key}&email=#{email}&password=#{password}") do |s| content = s.read end
    REXML::Document.new(content).root.text
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

  def self.get_store_products(cafepress_store_id, app_key = ENV['cp_app_key'])
    content = ''
    open("http://open-api.cafepress.com/product.listByStore.cp?v=3&appKey=#{app_key}&storeId=#{cafepress_store_id}&page=0&pageSize=#{RESULTS_PER_PAGE}") do |s| content = s.read end
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

  def self.get_design_url(cafepress_design_id, app_key = ENV['cp_app_key'])
    content = ''
    open("http://open-api.cafepress.com/design.find.cp?v=3&appKey=#{app_key}&id=#{cafepress_design_id}") do |s| content = s.read end
    doc = REXML::Document.new(content)
    doc.root.attributes['mediaUrl']
  end

  def self.get_store(cafepress_store_id, app_key = ENV['cp_app_key'])
    content = ''
    open("http://open-api.cafepress.com/store.findByStoreId.cp?v=3&appKey=#{app_key}&storeId=#{cafepress_store_id}") do |s| content = s.read end
    doc = REXML::Document.new(content)
    description = doc.root.attributes['description']

    store = Store.find_or_create_by_cafepress_store_id(cafepress_store_id)
    store.description = description
    store.save!
    store
  end
end