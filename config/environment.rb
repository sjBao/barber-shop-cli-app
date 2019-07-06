require 'bundler'
require 'active_support'
require 'active_support/core_ext' 

Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'app'