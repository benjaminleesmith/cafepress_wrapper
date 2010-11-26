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

begin
  ::CAFEPRESS_CONFIG = YAML.load_file("#{::Rails.root.to_s}/config/cafepress.yml")[::Rails.env]
rescue
  ::CAFEPRESS_CONFIG = {
    'app_key'  => ENV['cp_app_key'],
    'email'    => ENV['cp_email'],
    'password' => ENV['cp_password']
  }
end