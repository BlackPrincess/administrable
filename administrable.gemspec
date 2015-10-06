$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "administrable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "administrable"
  s.version     = Administrable::VERSION
  s.authors     = ["BlackPrincess"]
  s.email       = ["black.princess.w@gmail.com"]
  s.homepage    = "http://github.com/BlackPrincess/administrable"
  s.summary     = "Summary of Administrable."
  s.description = "Description of Administrable."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 4.2.1"
  s.add_dependency 'jquery-rails', '>= 3.1.2'
  s.add_dependency 'bootstrap-sass', '~> 3.3.5'
  s.add_dependency 'sass-rails', '>= 3.2'
  s.add_dependency 'coffee-rails', '>= 4.0.0'
  s.add_dependency 'haml-rails'
  s.add_dependency 'kaminari'
  s.add_dependency 'ransack'
  s.add_dependency 'enum_help'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "test-unit"
  s.add_development_dependency "test-unit-rails"
  s.add_development_dependency "test-unit-notify"
  s.add_development_dependency "test-unit-activesupport"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-test"
end
