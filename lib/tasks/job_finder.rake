namespace :job_finder do
  namespace :indeed do
    desc 'Search Job from Indeed based on category'
    task :run, [:category, :location, :page] do |_t, args|
      raise "Category and Location can't be blank" if args[:category].nil? || args[:location].nil?
      ap JobFinder::Crawler.new(JobFinder::Platform::INDEED, args).crawl
    end
  end
end
