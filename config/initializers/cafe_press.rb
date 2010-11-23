begin
  ::CAFEPRESS_CONFIG = YAML.load_file("#{::Rails.root.to_s}/config/cafepress.yml")[::Rails.env]
rescue
  ::CAFEPRESS_CONFIG = {
    'app_key'  => ENV['cp_app_key'],
    'email'    => ENV['cp_email'],
    'password' => ENV['cp_password']
  }
end