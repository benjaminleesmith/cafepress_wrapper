CafePress Wrapper
=================

Copyright 2010-2011 Benjamin Lee Smith <benjamin.lee.smith@gmail.com>

This file is part of CafePress Wrapper.
CafePress Wrapper is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

CafePress Wrapper is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with CafePress Wrapper.  If not, see <http://www.gnu.org/licenses/>.

INTRODUCTION
------------

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

EXAMPLE
-------

**1. Create new rails project**

	$ rails new cpw_test

	... bunch of rails output ...

	$ cd cpw_test

**2. Add the CafePress Wrapper gem by adding the following line to Gemfile**

	gem 'cafepress_wrapper'

**3. Install the gem**

	$ bundle install
	
	... bunch of output, make sure you see Installing/Using cafepress_wrapper ...
	...
	Installing cafepress_wrapper (0.0.3)
	...

**4. Create database**

	$ rake db:create

**5. Migrate database**

 	$ rake cafepress_wrapper:db:migrate

	... lots o' output ...

**6. Copy over static assets and config file**

 	$ rake cafepress_wrapper:install:all
	... list of files copied ...

**7. Remove default index.html**

	$ rm public/index.html

**8. Start rails server**

 	$ rails server

**9. Open http://localhost:3000/ in your web browser**

You should see a pretty blank page with just header/footer/menu

**10. Add a basic cafepress store by store id (humancrashpad for this example)**

	$ rake cafepress_wrapper:add_store[humancrashpad]

**11. Refresh http://localhost:3000/ **

And you're done. Add more stores using the cafepress_wrapper:add_store rake task