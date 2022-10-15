# frozen_string_literal: true

require 'http'
require_relative 'finmind'

module CodePraise
  class FinMindApi
    API_PROJECT_ROOT = 'https://api.finmindtrade.com/api/v4/data?'

    module Errors
      class NotFound < StandardError; end
      class Unauthorized < StandardError; end
      class UnprocessableEntity < StandardError; end
    end

    HTTP_ERROR = {
      401 => Errors::Unauthorized,
      404 => Errors::NotFound,
      422 => Errors::UnprocessableEntity
    }.freeze

    attr_reader :parameter

    def initialize
      @parameter = {}
    end

    def dataset(dataset)
      @parameter['dataset'] = dataset
    end

    def data_id(data_id)
      @parameter['data_id'] = data_id
    end

    def start_date(start_date)
      @parameter['start_date'] = start_date
    end

    def end_date(end_date)
      @parameter['end_date'] = end_date
    end

    def remove_set
      @parameter.delete('dataset')
    end

    def remove_id
      @parameter.delete('data_id')
    end

    def remove_start
      @parameter.delete('start_date')
    end

    def remove_end
      @parameter.delete('end_date')
    end

    def stock
      parameter = @parameter.to_a.map { |col| col.join('=') }.join('&')
      stock_url = fm_api_path(parameter)
      stock_data = call_fm_url(stock_url).parse
      FinMind.new(stock_data, self)
    end

    private

    def fm_api_path(path)
      "#{API_PROJECT_ROOT}#{path}"
    end

    def call_fm_url(url)
      result = HTTP.get(url)
      successful?(result) ? result : raise(HTTP_ERROR[result.code])
    end

    def successful?(result)
      !HTTP_ERROR.keys.include?(result.code)
    end
  end
end
