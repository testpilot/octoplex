require "bundler/gem_tasks"

$: << 'lib'

require "octoplex"
require 'rake'
require "rspec/core/rake_task"

desc "Run all examples"
RSpec::Core::RakeTask.new

task :default => :spec
