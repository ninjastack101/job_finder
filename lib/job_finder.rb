require 'faraday'
require 'nokogiri'
require 'json'
require 'pry'
require 'semantic_logger'
require 'job_finder/version'
require 'job_finder/platform'
require 'job_finder/indeed/scraper'
require 'job_finder/indeed/page/job_list'
require 'job_finder/exceptions'

SemanticLogger.default_level = :info
SemanticLogger.add_appender(file_name: 'job_finder.log')

module JobFinder
  # Your code goes here...
end
