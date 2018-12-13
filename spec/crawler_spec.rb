RSpec.describe JobFinder::Crawler do
  describe 'INDEED' do
    describe 'Invalid Arguments' do
      [{ category: 'sales' }, { location: 'london' }].each do |arg|
        it "should not contain only #{arg.keys.first} as input" do
          expect { JobFinder::Crawler.new(JobFinder::Platform::INDEED, arg).crawl }.to
          raise_error(JobFinder::UrlException)
        end
      end
      it 'should contain valid page number' do
        args = { category: 'sales', location: 'london', page: '1a' }
        expect { JobFinder::Crawler.new(JobFinder::Platform::INDEED, args).crawl }.to
        raise_error(JobFinder::PageNumberException)
      end

      it 'page should be greater than 0' do
        args = { category: 'sales', location: 'london', page: '0' }
        expect { JobFinder::Crawler.new(JobFinder::Platform::INDEED, args).crawl }.to
        raise_error(JobFinder::PageNumberException)
      end
    end

    describe 'Valid Arguments' do
      it 'should return valid response with correct arguments' do
        args = { category: 'sales', location: 'london', page: '2' }
        VCR.use_cassette('indeed_response') do
          expect(JobFinder::Crawler.new(JobFinder::Platform::INDEED, args).crawl[1]).not_to be match_array([])
        end
      end
    end
  end
end
