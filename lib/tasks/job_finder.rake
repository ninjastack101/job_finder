namespace :job_finder do
  namespace :indeed do
    desc 'Search Job from Indeed based on category'
    task :run, [:category, :location, :upto_page] do |_t, args|
      raise "Category and Location can't be blank" if args[:category].nil? || args[:location].nil?

      args = args.to_h
      args[:upto_page] = get_page(args[:upto_page])
      ap JobFinder::Crawler.new(JobFinder::Platform::INDEED[:name], args).crawl
    end
  end

  namespace :naukri do
    desc 'Search Job from Naukri based on category'
    task :run, [:category, :location, :upto_page] do |_t, args|
      p args
      raise 'Need to implement this'
    end
  end

  def get_page(upto_page)
    # By default it return results till 1st page
    return 1 if upto_page.nil?

    begin
      upto_page = Integer(upto_page)
    rescue ArgumentError => e
      raise JobFinder::PageNumberException, 'Page should be a valid integer'
    end
    raise JobFinder::PageNumberException, 'Page should be greater than 0' if upto_page.eql?(0)

    upto_page
  end
end
