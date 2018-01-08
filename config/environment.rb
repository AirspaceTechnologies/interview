ENV['RACK_ENV'] ||= "development"
require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

configure  do 
	set :database_file, 'database.yml'
end
