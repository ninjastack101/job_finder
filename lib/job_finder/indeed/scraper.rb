require 'job_finder'
module JobFinder
  module Indeed
    class Scraper
      include ::SemanticLogger::Loggable
      PAGE_MULTIPLIER = 10
      BASE_URL = URI(Platform::INDEED[:base_url])

      class << self
        def job_detail(params)
          (1..params[:upto_page]).each_with_object({}) do |upto_page, response|
            params[:start] = (upto_page - 1) * PAGE_MULTIPLIER
            response[upto_page] = get_jobs_data(params)
            response
          end
        end

        private

        def get_jobs_data(params)
          response = get_response(params)
          document = Nokogiri::HTML(response.body)
          scrap_document(document)
        end

        def get_response(params)
          response = open_url(params)
          raise UrlException, "Can't access the provided URL" unless response&.success?

          response
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
          connection = Faraday.new(url: BASE_URL)
          connection.get '/jobs', q: params[:category]&.strip, l: params[:location]&.strip, start: params[:start]
        rescue Faraday::ConnectionFailed => e
          logger.error "Faraday::ConnectionFailed Exception #{e.message}"
          raise e
        rescue StandardError => e
          logger.error "open_url Exception #{e.message}"
          raise e
        end
      end
    end
  end
end
