require 'job_finder'
module JobFinder
  module Indeed
    class Scraper
      include ::SemanticLogger::Loggable
      PAGE_MULTIPLIER = 10
      BASE_URL = URI('https://www.indeed.co.uk')

      class << self
        def job_detail(params)
          params = params.to_h
          page = get_page(params[:page])
          (1..page).each_with_object({}) do |page, response|
            params[:start] = (page - 1) * PAGE_MULTIPLIER
            response[page] = get_jobs_data(params)
            response
          end
        end

        private

        def get_jobs_data(params)
          response = open_url(params)
          raise UrlException, "Can't access the provided URL" unless response&.success?
          document = Nokogiri::HTML(response.body)
          scrap_document(document)
        end

        def scrap_document(document)
          document.css(Page::JobList.list).each_with_object([]) do |job, data|
            title = job.css(Page::JobList.title).text.strip
            company = job.css(Page::JobList.company).text.strip
            summary = job.css(Page::JobList.summary).text.strip
            wage = job.css(Page::JobList.wage).text.strip
            data << { title: title, company: company, summary: summary, wage: wage }
            data
          end
        end

        def open_url(params)
          connection = Faraday.new(url: BASE_URL.to_s)
          connection.get '/jobs', q: params[:category]&.strip, l: params[:location]&.strip, start: params[:start]
        rescue Faraday::ConnectionFailed => e
          logger.error "Faraday::ConnectionFailed Exception #{e.message}"
          nil
        rescue StandardError => e
          logger.error "open_url Exception #{e.message}"
          nil
        end

        def get_page(page)
          page = page ? (Integer(page) rescue nil) : 1
          raise PageNumberException, "Page should be a valid integer and greater than 0" if page.nil? || page.eql?(0)
          page
        end
      end
    end
  end
end
