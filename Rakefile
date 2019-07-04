require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'Start console sandbox to interact with models'
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end