class Store < ActiveRecord::Base
  validates_uniqueness_of :cafepress_store_id
  has_many :products
end
