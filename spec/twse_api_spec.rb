# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require_relative '.../TwseApi'

CORRECT = YAML.safe_load(File.read('.../twse_results.yml'))
STOCKCODE = 2330

describe 'Tests TWSE API library' do
  describe 'Project information' do
    it 'HAPPY: should provide correct stock information' do
      CORRECT_i = CORRECT['上市個股股價升降幅度'].select{ |x| x['Code'] == "#{STOCKCODE}" }
      # CORRECT_i 還是 [{}]
      CORRECT_i = CORRECT_i[0]
      # CORRECT_i 只剩 {}
      stock = CodePraise::TwseApi.new.twse_single(STOCKCODE)
      _(stock.pd_op).must_equal CORRECT_i["PreviousDayOpeningRefPrice"]
      _(stock.td_op).must_equal CORRECT_i["TodayOpeningRefPrice"]
      _(stock.pd_ld).must_equal CORRECT_i["PreviousDayLimitDown"]
      _(stock.td_ld).must_equal CORRECT_i["TodayLimitDown"]
      _(stock.pd_lu).must_equal CORRECT_i["PreviousDayLimitUp"]
      _(stock.td_lu).must_equal CORRECT_i["TodayLimitUp"]
    end

    it 'SAD: should raise exception on incorrect stock information' do
      _(proc do
        CodePraise::TwseApi.new.twse_single(0000)
      end).must_raise CodePraise::TwseApi::Errors::NotFound
    end

  end

  describe 'stock rank information' do
    before do
      @rank = CodePraise::TwseApi.new.twse_rank
    end

    it 'HAPPY: should check top 5' do
      reference = CORRECT['集中市場每日成交量前二十名證券'].select { |x| x["Rank"].to_i < 6 }
      _(@rank.info(5)).must_equal reference
    end

    it 'HAPPY: should check total number of ranks' do
      alltopstock = @rank.info(20)
      _(alltopstock.count).must_equal CORRECT['集中市場每日成交量前二十名證券'].count

    end
  end
end
