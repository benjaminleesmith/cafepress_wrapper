# Copyright 2010-2011 Benjamin Lee Smith <benjamin.lee.smith@gmail.com>
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

Gem::Specification.new do |s|
  s.author = 'Benjamin Lee Smith'
  s.name = "cafepress_wrapper"
  s.description = <<-EOF
    CafePress Wrapper was built to create a portal for multiple CafePress basic stores.
    The intent is to create a fully fledged site where all product browsing and searching
    is done on the wrapper site, while shopping cart functionality and checkout is all
    done normally on cafepress.com

    The use case for which this is best used, is to combine several different basic
    CafePress stores. Each cafepress store containing many products, but only a single
    design. For example, http://rockclimbingshirts.com/ combines the following CafePress
    basic stores: http://www.cafepress.com/carabinerpirate http://www.cafepress.com/humancrashpad
    http://www.cafepress.com/midnight_lightning http://www.cafepress.com/be_safe_use_pro
    and http://www.cafepress.com/tightharness

    CafePress Wrapper is a Rails plugin distributed as a gem. Runs great on Heroku.
  EOF
  s.summary = "CafePress Wrapper was built to create a portal for multiple CafePress basic stores."
  s.email = 'benjamin.lee.smith@gmail.com'
  s.homepage = 'https://github.com/benjaminleesmith/cafepress_wrapper'
  s.license = 'GPL-3'
  s.files = Dir["{app,lib,config,public}/**/*"] + ["LICENSE", "Rakefile", "Gemfile", "README.md"]
  s.version = "0.1.0"
  s.add_dependency('cafepress_api', '~> 0.3.2')
end