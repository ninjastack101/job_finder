require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require './lib/job_finder/crawler'
require './lib/job_finder/platform'
require './lib/job_finder/exceptions'
require 'awesome_print'

RSpec::Core::RakeTask.new(:spec)

task default: :spec
import './lib/tasks/job_finder.rake'
