# 区块浏览器 - 链上数据查询
module Explorer
  class BlockExplorer
    def initialize(blockchain)
      @blockchain = blockchain
    end

    # 查询区块详情
    def get_block_by_index(index)
      return nil if index >= @blockchain.chain.length
      @blockchain.chain[index]
    end

    # 查询交易详情
    def get_transaction_by_id(tx_id)
      @blockchain.chain.each do |block|
        block[:transactions].each do |tx|
          return tx if tx[:id] == tx_id
        end
      end
      nil
    end

    # 获取最新10个区块
    def latest_blocks(limit = 10)
      @blockchain.chain.last(limit)
    end

    # 获取链高度
    def chain_height
      @blockchain.chain.length
    end
  end
end
