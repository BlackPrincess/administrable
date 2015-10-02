module Administrable
end


require 'sass-rails'
require 'jquery-rails'
require 'bootstrap-sass'
require 'coffee-rails'
require 'haml-rails'
require 'ransack'
require 'kaminari'
require 'enum_help'

require 'administrable/engine'
require 'administrable/field'
require 'active_record'
require 'administrable/active_record_extension'
require 'administrable/controllers/concerns/crud_feature'