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

class Store < ActiveRecord::Base
  validates_uniqueness_of :cafepress_store_id
  has_many :products

  def self.load_cafepress_store(cafepress_store_id)
    store = Store.find_or_create_by_cafepress_store_id(cafepress_store_id)
    cafepress_store_attributes = CafePressAPI.get_store(cafepress_store_id)
    store.description = cafepress_store_attributes[:description]
    store.save!
    store
  end

  def self.load_cafepress_store_and_products(cafepress_store_id)
    store = Store.load_cafepress_store(cafepress_store_id)

    store.products.destroy_all

    cafepress_store_products = CafePressAPI.get_store_products(cafepress_store_id)

    cafepress_store_products.each do |cp_store_attributes|
      store.products.build(cp_store_attributes)
    end

    store.save!
    store

    design_url = CafePressAPI.get_design_url(store.products.first.cafepress_design_id)
    store.update_attributes(:cafepress_design_url => design_url)

    if store.products.first.cafepress_back_design_id
      design_url = CafePressAPI.get_design_url(store.products.first.cafepress_back_design_id)
      store.update_attributes(:cafepress_back_design_url => design_url)
    end
  end

  def mens_products
    products.find_all_by_gender(CafePressAPI::MALE)
  end

  def womens_products
    products.find_all_by_gender(CafePressAPI::FEMALE)
  end

  def unisex_products
    products.find_all_by_gender(CafePressAPI::UNISEX)
  end
end
