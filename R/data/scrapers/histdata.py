# imports - standard modules
import sys, os

# imports - third-party modules
from fake_useragent        import UserAgent
from scrapy.spiders        import CrawlSpider, Rule
from scrapy.linkextractors import LinkExtractor
from scrapy.http           import FormRequest
from scrapy.crawler        import CrawlerProcess
from bs4                   import BeautifulSoup

# imports - module imports
from utils                 import makedirs

DEFAULT_CACHEDIR = os.path.join(os.path.expanduser('~'), '_uniquant')

def write_file(response):
    parameters = response.headers['Content-Disposition'].decode('utf-8')
    filename   = parameters.split('=')[-1]

    dircache   = os.getenv('UNIQUANT_CACHEDIR', DEFAULT_CACHEDIR)
    dirdata    = os.path.join(dircache, 'histdata')

    makedirs(dirdata, exists_ok = True)

    path       = os.path.join(dirdata, filename)

    with open(path, 'wb') as f:
        buffrr = response.body

        f.write(buffrr)

class HistDataSpider(CrawlSpider):
    name             = 'histdata'
    allowed_domains  = ['histdata.com']
    start_urls       = ['http://histdata.com/download-free-forex-data']

    rules            = [
        Rule(
            LinkExtractor(
                allow = 'download-free-forex-historical-data/\?/[a-z]+/(-?[a-z]+)+/[a-z]{6}/[0-9]{4}/[0-9]{1,2}'
            )
        , callback    = 'parse_item'),
        Rule(
            LinkExtractor(
                allow = 'download-free-forex(-historical)?-data/\?/([a-z]+/(-?[a-z]+)+(/([a-z]{6}|[A-Z]{6})?(/[0-9]{4})?)?)?'
            )
        , follow      = True)
    ]

    def parse_item(self, response):
        body  = response.body
        soup  = BeautifulSoup(body, 'html.parser')
        form  = soup.find(id = 'file_down')
        data  = dict((dom.get('name'), dom.get('value'))
            for dom in form.find_all('input')
        )

        req   = FormRequest.from_response(
            response = response,
            formid   = 'file_down',
            formdata = data,
            callback = write_file
        )

        return req

def main(args = None):
    agent     = UserAgent()
    process   = CrawlerProcess({ 'USER_AGENT': agent.chrome })

    process.crawl(HistDataSpider)
    process.start()

if __name__ == '__main__':
    args = sys.argv[1:]
    code = main(args)

    sys.exit(code)
