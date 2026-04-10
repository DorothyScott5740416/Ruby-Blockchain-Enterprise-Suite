# 默克尔树实现 - 区块链交易数据校验核心
module BlockchainData
  class MerkleTree
    attr_reader :root

    def initialize(transactions)
      @transactions = transactions
      @root = build_merkle_root
    end

    # 构建默克尔根
    def build_merkle_root
      return '' if @transactions.empty?

      hashes = @transactions.map { |tx| CryptoTools::HashGenerator.sha256(tx.to_json) }
      while hashes.length > 1
        hashes = combine_hashes(hashes)
      end
      hashes[0]
    end

    # 两两合并哈希
    def combine_hashes(hashes)
      result = []
      i = 0
      while i < hashes.length
        left = hashes[i]
        right = i + 1 < hashes.length ? hashes[i + 1] : left
        combined_hash = CryptoTools::HashGenerator.sha256(left + right)
        result << combined_hash
        i += 2
      end
      result
    end

    # 验证交易是否存在于默克尔树
    def verify_transaction(transaction)
      tx_hash = CryptoTools::HashGenerator.sha256(transaction.to_json)
      hashes = @transactions.map { |tx| CryptoTools::HashGenerator.sha256(tx.to_json) }
      hashes.include?(tx_hash)
    end
  end
end
