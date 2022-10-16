require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require_relative '../lib/finmind_api.rb'

CORRECT = YAML.safe_load(File.read('fixtures/finmind_results.yml'))

describe 'Tests FinMind API library' do
  stock = CodePraise::FinMindApi.new
  stock.dataset("TaiwanStockInfo")
  describe 'Status' do
    it 'stock_dataset' do
      _(stock.stock.get_stock["status"]).must_equal CORRECT["status"]
    end
  end
  describe 'Msg' do
    it 'stock_dataset' do
       _(stock.stock.get_stock["msg"]).must_equal CORRECT["msg"]
    end
  end
  describe 'Data' do
    it 'stock_dataset' do
       _(stock.stock.get_stock["data"]).must_equal CORRECT["data"]
    end
  end
end
      
