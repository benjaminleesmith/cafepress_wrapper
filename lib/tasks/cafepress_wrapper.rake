namespace :db do
  namespace :migrate do
    description = "Migrate the database through scripts in vendor/plugins/cafepress_wrapper/lib/db/migrate"
    description << "and update db/schema.rb by invoking db:schema:dump."
    description << "Target specific version with VERSION=x. Turn off output with VERBOSE=false."
 
    desc description
    task :cafepress_wrapper => :environment do
      ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
      ActiveRecord::Migrator.migrate(File.join(File.dirname(__FILE__),'../db/migrate/'), ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
      Rake::Task["db:schema:dump"].invoke if ActiveRecord::Base.schema_format == :ruby
    end
  end
end

namespace :cafepress_wrapper do
  desc "Reload all cafepress data"
  task :reload_data => :environment do
    Store.load_all_stores_cafepress_data
  end
  
  namespace :install do
    def copy_files(source, destination)
      FileUtils.cp_r((Dir.entries(source) - ['.', '..']).collect{|s| "#{source}/#{s}"}, destination)
    end
    
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
  end
end

desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  puts 'reloading all store data'
  Store.load_all_stores_cafepress_data
end