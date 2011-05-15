# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "cafepress_wrapper"
  s.summary = "Insert CafepressWrapper summary."
  s.description = "Insert CafepressWrapper description."
  s.files = Dir["{app,lib,config,public}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.rdoc"]
  s.version = "0.0.2"
  s.add_dependency('cafepress_api', '~> 0.3.2')
end