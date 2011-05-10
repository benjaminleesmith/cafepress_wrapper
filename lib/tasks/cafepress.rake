namespace :cafepress do
  desc "Reload all cafepress data"
  task :reload_data => :environment do
    Store.load_all_stores_cafepress_data
  end
end
