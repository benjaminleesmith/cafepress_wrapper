require 'cafepress_api'

module CafepressWrapper
  class Engine < Rails::Engine
    config.autoload_paths << File.join(File.dirname(__FILE__),'../app/models/')
    config.autoload_paths << File.join(File.dirname(__FILE__),'../app/controllers/')
  end
end