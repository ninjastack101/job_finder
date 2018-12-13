require 'job_finder'
module JobFinder
  class Crawler
    attr_reader :platform, :query_params

    def initialize(platform, query_params)
      @platform = platform
      @query_params = query_params
    end

    def crawl
      raise UnsupportedPlatformException, "Invalid #{platform} platform" unless platforms.include?(platform.downcase)

      Object.const_get("JobFinder::#{platform.capitalize}::Scraper").job_detail(query_params)
    end

    private

    def platforms
      Platform.constants.collect { |c| c.to_s.downcase }
    end
  end
end
