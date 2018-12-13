module JobFinder
  module Indeed
    module Page
      class JobList
        class << self
          def list
            'body #resultsCol .jobsearch-SerpJobCard'
          end

          def title
            '.jobtitle'
          end

          def company
            '.companyInfoWrapper .company'
          end

          def summary
            '.paddedSummary .summary'
          end

          def wage
            '.salarySnippet'
          end
        end
      end
    end
  end
end
