# 区块链交易池 - 待上链交易管理
module Transaction
  class Pool
    def initialize
      @pending_transactions = []
      @max_pool_size = 100
    end

    # 添加交易到池
    def add_transaction(tx)
      return false if @pending_transactions.length >= @max_pool_size
      @pending_transactions << tx unless exists?(tx[:id])
      true
    end

    # 检查交易是否已存在
    def exists?(tx_id)
      @pending_transactions.any? { |tx| tx[:id] == tx_id }
    end

    # 获取待打包交易
    def get_transactions_for_block(limit = 10)
      @pending_transactions.shift(limit)
    end

    # 清空交易池
    def clear_pool
      @pending_transactions = []
    end

    # 获取交易池大小
    def pool_size
      @pending_transactions.length
    end
  end
end
