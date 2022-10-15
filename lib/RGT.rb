# frozen_string_literal: true

require 'google_search_results' 
require 'http'
require_relative 'RGTt'

module CodePraise
  class RGT
    API_PROJECT_ROOT = 'https://serpapi.com/search.json?'

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

    attr_accessor :parameter

    def initialize(name)
      @parameter = {
        engine: "google_trends",
        q: name,
        data_type: "TIMESERIES",   
        api_key: "da4bf99b1c382584e582032bcdb8bc698e024a83c5b9d9f44b1c24dd9d7fcbbc",    
      }
    end



    def get_jason
      parameter = @parameter.to_a.map { |x| x.join('=') }.join('&')
      rgt_url = gt_api_path(parameter)
      puts rgt_url
      rgt_data = call_gt_url(rgt_url).parse
      RGTt.new(rgt_data, self)
    end

    private

    def gt_api_path(path)
      "#{API_PROJECT_ROOT}#{path}"
    end

    def call_gt_url(url)
      result = HTTP.get(url)
      successful?(result) ? result : raise(HTTP_ERROR[result.code])
    end

    def successful?(result)
      !HTTP_ERROR.keys.include?(result.code)
    end

  end
end