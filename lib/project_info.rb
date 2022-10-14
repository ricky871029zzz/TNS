require 'http'
require 'yaml'


def fm_api_path(path)
  'https://api.finmindtrade.com/api/v4/data?'+path
end

def call_fm_url(url)
  HTTP.get(url)
end

def stock_data(data)
  data.each { |stock| puts stock}
end
fm_response = {}
fm_results = {}
project_url = fm_api_path('dataset=TaiwanStockInfo')
fm_response[project_url] = call_fm_url(project_url)
project = fm_response[project_url].parse

fm_results['msg'] = project['msg']

fm_results['status'] = project['status']

fm_results['data'] = project['data']

puts stock_data(fm_results['data'])
