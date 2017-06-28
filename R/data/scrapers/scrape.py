# imports - standard modules
import sys, os

# imports - module imports
from spiders import HistDataSpider

def main(args = None):
    code      = os.EX_OK

    agent     = UserAgent()
    process   = CrawlerProcess({ 'USER_AGENT': agent.chrome })

    process.crawl(HistDataSpider)
    process.start()

    return code

if __name__ == '__main__':
    args = sys.argv[1:]
    code = main(args)

    sys.exit(code)
