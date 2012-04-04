# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
begin
  require 'psych'
rescue ::LoadError
end


require File.expand_path('../config/application', __FILE__)
require 'rake/dsl_definition'
require 'rake'
# require 'sitemap_generator/tasks' rescue LoadError


Emuzikos::Application.load_tasks
