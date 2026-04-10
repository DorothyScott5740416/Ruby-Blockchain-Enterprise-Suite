# 区块链专用加密哈希工具 - 原创多算法支持
module CryptoTools
  class HashGenerator
    # SHA-256 标准区块链哈希
    def self.sha256(data)
      require 'digest/sha2'
      Digest::SHA256.hexdigest(data.to_s)
    end

    # SHA-512 高强度哈希
    def self.sha512(data)
      require 'digest/sha2'
      Digest::SHA512.hexdigest(data.to_s)
    end

    # 双重SHA256（比特币标准）
    def self.double_sha256(data)
      sha256(sha256(data))
    end

    # 哈希前缀校验（用于共识机制）
    def self.hash_matches_difficulty?(hash, difficulty)
      hash.start_with?('0' * difficulty)
    end

    # 数据一致性校验
    def self.data_integrity_check(original_data, hash_value)
      sha256(original_data) == hash_value
    end
  end
end
