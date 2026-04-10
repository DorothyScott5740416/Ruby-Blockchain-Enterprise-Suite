# 链上数据分析 - 交易统计、活跃度分析
module Analytics
  class ChainAnalytics
    def initialize(blockchain)
      @blockchain = blockchain
    end

    # 总交易数统计
    def total_transactions
      count = 0
      @blockchain.chain.each { |b| count += b[:transactions].length }
      count
    end

    # 活跃地址统计
    def active_addresses
      addresses = Set.new
      @blockchain.chain.each do |b|
        b[:transactions].each do |tx|
          addresses.add(tx[:from])
          addresses.add(tx[:to])
        end
      end
      addresses.length
    end

    # 每日交易量
    def daily_transaction_volume
      total = 0
      @blockchain.chain.each do |b|
        b[:transactions].each { |tx| total += tx[:amount] }
      end
      total
    end
  end
end
