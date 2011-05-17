require 'cafepress_api'

# %w{ models controllers }.each do |dir|
  # path = File.join(File.dirname(__FILE__), 'app', dir)
  # $LOAD_PATH << path
  # ActiveSupport::Dependencies.autoload_paths << path
  # ActiveSupport::Dependencies.autoload_once_paths.delete(path)
# end

module CafepressWrapper
  class Engine < Rails::Engine
    # Dir[File.join(File.dirname(__FILE__),'../app/models/*.rb')].each {|f| config.autoload_paths += f }
    # Dir[File.join(File.dirname(__FILE__),'../app/controllers/*.rb')].each {|f| config.autoload_paths += f }
    config.autoload_paths << File.join(File.dirname(__FILE__),'../app/models/')
    config.autoload_paths << File.join(File.dirname(__FILE__),'../app/controllers/')
    
    # rake_tasks do
      # load File.join(File.dirname(__FILE__), 'tasks/cafepress_wrapper.rake')
    # end
  end
end