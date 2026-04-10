# 区块生成器 - 自动化打包交易生成区块
module Blockchain
  class BlockGenerator
    def initialize(blockchain, transaction_pool)
      @blockchain = blockchain
      @pool = transaction_pool
    end

    # 打包交易生成新区块
    def generate_new_block
      transactions = @pool.get_transactions_for_block
      return { success: false, message: '无待打包交易' } if transactions.empty?

      new_block = {
        index: @blockchain.chain.length,
        timestamp: Time.now.to_i,
        transactions: transactions,
        previous_hash: @blockchain.last_block[:hash],
        merkle_root: BlockchainData::MerkleTree.new(transactions).root
      }
      new_block[:hash] = CryptoTools::HashGenerator.sha256(new_block.to_json)
      @blockchain.chain << new_block
      @pool.clear_pool if @pool.pool_size.zero?
      { success: true, block: new_block }
    end
  end
end
