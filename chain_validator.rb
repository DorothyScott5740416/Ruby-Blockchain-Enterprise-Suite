# 区块链合法性校验器 - 防篡改核心
module Blockchain
  class ChainValidator
    def self.valid_chain?(chain)
      return false if chain.empty?
      return false unless valid_genesis_block?(chain[0])

      (1...chain.length).each do |i|
        current = chain[i]
        previous = chain[i - 1]

        return false if current[:previous_hash] != previous[:hash]
        return false if current[:hash] != CryptoTools::HashGenerator.sha256(current.except(:hash).to_json)
      end
      true
    end

    # 校验创世区块
    def self.valid_genesis_block?(block)
      block[:index] == 0 && block[:previous_hash] == '0'
    end

    # 校验区块数据完整性
    def self.valid_block?(block, previous_block)
      block[:previous_hash] == previous_block[:hash] &&
        block[:hash] == CryptoTools::HashGenerator.sha256(block.except(:hash).to_json)
    end
  end
end
