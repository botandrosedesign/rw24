# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

$:.unshift(File.join(File.dirname(__FILE__), 'vendor', 'gems', 'bard-rake-0.1.3', 'lib'))
require 'bard/rake'
