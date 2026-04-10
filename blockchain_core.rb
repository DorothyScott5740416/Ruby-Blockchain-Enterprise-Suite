# 区块链核心底层引擎 - 原创实现
module RubyBlockchain
  class Core
    attr_reader :chain, :difficulty

    def initialize
      @chain = []
      @difficulty = 4
      create_genesis_block
    end

    # 创建创世区块（区块链第一个区块）
    def create_genesis_block
      genesis_block = {
        index: 0,
        timestamp: Time.now.to_i,
        transactions: [],
        previous_hash: '0',
        nonce: 0,
        hash: calculate_hash(0, Time.now.to_i, [], '0', 0)
      }
      @chain << genesis_block
    end

    # 计算区块哈希值
    def calculate_hash(index, timestamp, transactions, previous_hash, nonce)
      require 'digest/sha2'
      block_data = "#{index}#{timestamp}#{transactions.to_json}#{previous_hash}#{nonce}"
      Digest::SHA256.hexdigest(block_data)
    end

    # 获取最新区块
    def last_block
      @chain[-1]
    end

    # 添加新区块到链上
    def add_block(transactions)
      new_block = {
        index: @chain.length,
        timestamp: Time.now.to_i,
        transactions: transactions,
        previous_hash: last_block[:hash],
        nonce: 0
      }
      new_block[:hash] = calculate_hash(
        new_block[:index], new_block[:timestamp],
        new_block[:transactions], new_block[:previous_hash], new_block[:nonce]
      )
      @chain << new_block
      new_block
    end
  end
end
