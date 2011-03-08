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

class Product < ActiveRecord::Base
  belongs_to :store
  has_many :image_urls, :dependent => :destroy
  has_many :sizes, :dependent => :destroy

  THUMBNAIL_IMAGE_SIZE = '100'
  LARGE_IMAGE_SIZE = '350'

  def front_thumbnail_urls
    image_urls.find_all_by_view_and_size(CafePressAPI::FRONT_PRODUCT_VIEW, THUMBNAIL_IMAGE_SIZE)
  end

  def default_front_image
    if default_color_id
      image_urls.find_by_view_and_size_and_color_id(CafePressAPI::FRONT_PRODUCT_VIEW, LARGE_IMAGE_SIZE, default_color_id)
    else
      # Sometimes there is no default color returned from the API, so just pick one
      image_urls.find_by_view_and_size(CafePressAPI::FRONT_PRODUCT_VIEW, LARGE_IMAGE_SIZE)
    end
  end

  def front_image_url_for_color(color_id)
    image_urls.find_by_view_and_size_and_color_id(CafePressAPI::FRONT_PRODUCT_VIEW, LARGE_IMAGE_SIZE, color_id).url
  end

  def color_ids
    front_thumbnail_urls.map(&:color_id)
  end

  def default_front_thumbnail_url
    if default_color_id
      image_urls.find_by_view_and_size_and_color_id(CafePressAPI::FRONT_PRODUCT_VIEW, THUMBNAIL_IMAGE_SIZE, default_color_id).url
    else
      # Sometimes there is no default color returned from the API, so just pick one
      image_urls.find_by_view_and_size(CafePressAPI::FRONT_PRODUCT_VIEW, THUMBNAIL_IMAGE_SIZE).url
    end
  end

  def sizes_array
    sizes.collect{|s| [s.full_name, s.cafepress_size_id]}
  end

  def available_in_multiple_colors?
    color_ids.length > 1
  end

  def has_sizes?
    sizes.length > 0
  end
end
