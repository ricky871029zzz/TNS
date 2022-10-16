# frozen_string_literal: true

module CodePraise
  class TwseSingle
    def initialize(stock_data, data_source)
      @stock = stock_data
      @data_source = data_source
    end

    def open_price_compare
      puts @stock['Name']
      puts "昨日開盤價為: #{@stock["PreviousDayOpeningRefPrice"]}"
      puts "今日開盤價為: #{@stock["TodayOpeningRefPrice"]}"
    end

    def limit_compare
      puts @stock["Name"]
      puts "昨日跌停價為: #{@stock["PreviousDayLimitDown"]}  今日跌停價為: #{@stock["TodayLimitDown"]}"
      puts "昨日漲停價為: #{@stock["PreviousDayLimitUp"]}  今日漲停價為: #{@stock["TodayLimitUp"]}"
    end

    def info
      puts "#{@stock["Name"]}昨日"
      puts "開盤價為: #{@stock["PreviousDayOpeningRefPrice"]}"
      puts "跌停價為: #{@stock["PreviousDayLimitDown"]}"
      puts "漲停價為: #{@stock["PreviousDayLimitUp"]}"
      puts "收盤價為: #{@stock["PreviousDayPrice"]}"
      print "\n" 
      puts "#{@stock["Name"]}今日"
      puts "開盤價為: #{@stock["TodayOpeningRefPrice"]}"
      puts "跌停價為: #{@stock["TodayLimitDown"]}"
      puts "漲停價為: #{@stock["TodayLimitUp"]}" 
    end
  end
end