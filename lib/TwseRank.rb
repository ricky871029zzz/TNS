# frozen_string_literal: true

module CodePraise
    class TwseRank
      def initialize(rank_data, data_source)
        @rank = rank_data
        @data_source = data_source
      end
  
      def info(num)
        puts "每日成交量(股數)前#{num}名之證券:"
        @rank = @rank.select { |x| x["Rank"].to_i < (num+1) }
        @rank.each { |x|  
          puts "#{x["Rank"]}: #{x["Name"]}"
          puts "成交量: #{x["TradeVolume"]}"
        }
      end
  
    end
  end