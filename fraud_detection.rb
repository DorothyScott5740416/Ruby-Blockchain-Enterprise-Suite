# 链上欺诈检测 - 异常交易识别
module Security
  class FraudDetection
    def initialize
      @blacklist = Set.new
      @max_single_tx = 1_000_000
    end

    # 加入黑名单
    def blacklist_address(address)
      @blacklist.add(address)
    end

    # 欺诈检测
    def detect(transaction)
      return true if @blacklist.include?(transaction[:from])
      return true if transaction[:amount] > @max_single_tx
      return true if suspicious_pattern?(transaction)
      false
    end

    # 可疑模式识别
    def suspicious_pattern?(tx)
      tx[:from] == tx[:to] || tx[:amount] <= 0
    end
  end
end
