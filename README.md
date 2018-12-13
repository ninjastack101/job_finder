# JobFinder

JobFinder is a gem which do web-scraping and fetch jobs from different platforms. It supports indeed platform only as of now. It is a scalable solution and easy to add other platform scrappers as well.

# To get jobs from indeed run
```
rake job_finder:indeed:run[sales,london]
```
It will print list of jobs in the form of hash available on indeed. Category and location are the required arguments. The results may vary due to browser caching, so please prefer incognito window for validating results.

# Pagination
It also support pagination but it is optional. You can provide third argument as page number like otherwise it will scrap first page by default.
```
rake job_finder:indeed:run[sales,london,2]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Future Enhancements
# Add more platforms other than Indeed.
# Support 301 redirects while fetching html responses
# Extracting website / email / phone
# Add mechanize gem support to support clicks
# scraping from the linked job pages in addition to the main search page
# scraping multiple search results pages
# Need to implement logic for stoping pagination iteration if result is blank
# Raise errors if Page orientation/css changes
# Retry logic for accessing url
# Validate & manage rate limiting with exponential backoff

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sumitr0902/job_finder. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the JobFinder project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/sumitr0902/job_finder/blob/master/CODE_OF_CONDUCT.md).
