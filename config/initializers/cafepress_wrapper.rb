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
  yaml_config = YAML.load_file("#{::Rails.root.to_s}/config/cafepress_wrapper.yml")[::Rails.env]
  Rails.configuration.cpw_name = yaml_config['name']
  Rails.configuration.cpw_title = yaml_config['title']
  Rails.configuration.cpw_description = yaml_config['description']
  Rails.configuration.cpw_photos_url = yaml_config['photos_url']
  Rails.configuration.cpw_google_analytics = yaml_config['google_analytics']
rescue
  begin
    Rails.configuration.cpw_name = yaml_config['cpw_name']
    Rails.configuration.cpw_title = yaml_config['cpw_title']
    Rails.configuration.cpw_description = yaml_config['cpw_description']
    Rails.configuration.cpw_photos_url = yaml_config['cpw_photos_url']
    Rails.configuration.cpw_google_analytics = yaml_config['cpw_google_analytics']
  rescue
    #maybe config file hasn't been copied over yet via rake cafepress:install:assets
  end
end

require 'rails/generators'

class InstallGenerator < Rails::Generators::Base
  def copy_config_file
    source = File.join(File.dirname(__FILE__), '..', '..', 'config')
    destination = File.join(Rails.root, 'config', 'cafepress_wrapper.yml')
    
    InstallGenerator.source_root(source)
    
    copy_file 'cafepress_wrapper.yml', destination
  end
  
  def copy_images
    source = File.join(File.dirname(__FILE__), '..', '..', 'public', 'images')
    destination = File.join(Rails.root, 'public', 'images')
    copy_files(source, destination)
  end
  
  def copy_javascripts
    source = File.join(File.dirname(__FILE__), '..', '..', 'public', 'javascripts')
    destination = File.join(Rails.root, 'public', 'javascripts')
    copy_files(source, destination)
  end
  
  def copy_stylesheets
    source = File.join(File.dirname(__FILE__), '..', '..', 'public', 'stylesheets')
    destination = File.join(Rails.root, 'public', 'stylesheets')
    copy_files(source, destination)
  end
  
  private
    def copy_files(source, destination)
      InstallGenerator.source_root(source)
      (Dir.entries(source) - ['.', '..']).each do |f|
        copy_file f, File.join(destination, f)
      end
    end
end