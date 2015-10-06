# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)

Rails.backtrace_cleaner.remove_silencers!

ActiveRecord::Migrator.migrations_paths = %w(db/migrate test/dummy/db/migrate)
# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

base_dir = File.expand_path(File.join(File.dirname(__FILE__), ".."))
lib_dir  = File.join(base_dir, "lib")
test_dir = File.join(base_dir, "test")

$LOAD_PATH.unshift(lib_dir)

require 'test/unit'
require 'test/unit/rr'
require 'test/unit/rails/test_help'
require "test/unit/notify"
require "test/unit/active_support"

exit Test::Unit::AutoRunner.run(true, test_dir)
