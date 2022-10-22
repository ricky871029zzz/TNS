require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require_relative 'lib/RGT.rb'

CORRECT = YAML.safe_load(File.read('/Users/yehanzhang/Desktop/RGT/spec/fixture/rgt_results.yml'))

describe 'Tests RGT API library' do
  p = CodePraise::RGT.new("TSMC")
  describe 'search_metadata' do
    it 'search_metadata' do
      _(p.get_jason.get_rgt["search_metadata"]).must_equal CORRECT["search_metadata"]
    end
  end
  describe 'search_parameters' do
    it 'search_parameters' do
       _(p.get_jason.get_rgt["search_parameters"]).must_equal CORRECT["search_parameters"]
    end
  end
  describe 'interest_over_time' do
    it 'interest_over_time' do
       _(p.get_jason.get_rgt["interest_over_time"]).must_equal CORRECT["interest_over_time"]
    end
  end
end
