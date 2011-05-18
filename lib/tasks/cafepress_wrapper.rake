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

namespace :db do
  namespace :migrate do
    desc "Migrate the database through scripts in vendor/plugins/cafepress_wrapper/lib/db/migrate"
    task :cafepress_wrapper => :environment do
      ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
      ActiveRecord::Migrator.migrate(File.join(File.dirname(__FILE__),'../db/migrate/'), ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
      Rake::Task["db:schema:dump"].invoke if ActiveRecord::Base.schema_format == :ruby
    end
  end
end

namespace :cafepress_wrapper do
  namespace :db do
    desc "Migrate the database through scripts in vendor/plugins/cafepress_wrapper/lib/db/migrate"
    task :migrate => :environment do
      Rake::Task['db:migrate:cafepress_wrapper'].invoke
    end    
  end
  
  desc 'Add a cafepress store'
  task :add_store, [:store_id]  => :environment  do |t, args|
    Store.load_cafepress_store_and_products(args.store_id)
  end



  desc "Reload all cafepress data"
  task :reload_data => :environment do
    Store.load_all_stores_cafepress_data
  end
  
  namespace :install do
    desc 'Copy static assets (images, javascript and stylesheets), into public directory'
    task :assets => :environment do
      Rails::Generators::Base.invoke 'install:copy_images'
      Rails::Generators::Base.invoke 'install:copy_javascripts'
      Rails::Generators::Base.invoke 'install:copy_stylesheets'
      Rails::Generators::Base.start
    end
    
    desc 'Copy config file (config/cafepress_wrapper.yml) into config directory'
    task :config => :environment do
      Rails::Generators::Base.invoke 'install:copy_config_file'
      Rails::Generators::Base.start
    end
    
    desc 'Copy images, javascripts, stylesheets, and configuration files'
    task :all => :environment do
      Rails::Generators::Base.invoke 'install:copy_images'
      Rails::Generators::Base.invoke 'install:copy_javascripts'
      Rails::Generators::Base.invoke 'install:copy_stylesheets'
      Rails::Generators::Base.invoke 'install:copy_config_file'
      Rails::Generators::Base.start
    end
  end
end

desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  puts 'reloading all store data'
  Store.load_all_stores_cafepress_data
end