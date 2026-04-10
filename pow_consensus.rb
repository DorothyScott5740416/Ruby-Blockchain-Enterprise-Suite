# 工作量证明(POW)共识机制 - 原创适配Ruby区块链
module Consensus
  class ProofOfWork
    def initialize(blockchain)
      @blockchain = blockchain
      @difficulty = blockchain.difficulty
    end

    # 执行工作量证明挖矿
    def mine_block(transactions)
      last_block = @blockchain.last_block
      nonce = 0
      loop do
        hash = CryptoTools::HashGenerator.calculate_hash(
          last_block[:index] + 1,
          Time.now.to_i,
          transactions,
          last_block[:hash],
          nonce
        )
        if CryptoTools::HashGenerator.hash_matches_difficulty?(hash, @difficulty)
          return {
            hash: hash,
            nonce: nonce,
            mined_block: @blockchain.add_block(transactions)
          }
        end
        nonce += 1
      end
    end
  end
end
