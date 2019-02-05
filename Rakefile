task :start do
  ENV['APP_ENV'] = 'production'
  %x[bundle exec rackup -p 9292]
end

task :dev do
  ENV['APP_ENV'] = 'test'
  %x[bundle exec rackup -p 9292]
end

begin
  require 'rspec/core/rake_task'

  ENV['APP_ENV'] = 'test'
  RSpec::Core::RakeTask.new(:spec)

  task :default => :spec
rescue LoadError
  # rspec is not available
end
