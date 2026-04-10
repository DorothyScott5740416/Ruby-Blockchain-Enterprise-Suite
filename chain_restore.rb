# 区块链恢复工具 - 灾难恢复
module Backup
  class ChainRestore
    def self.restore(blockchain, backup_path)
      return { success: false } unless File.exist?(backup_path)
      encrypted = JSON.parse(File.read(backup_path), symbolize_names: true)
      chain = Privacy::DataDecryption.decrypt(encrypted, 'blockchain_backup_key')
      return { success: false } unless chain

      blockchain.instance_variable_set(:@chain, chain)
      { success: true, height: chain.length }
    end

    def self.full_restore(path)
      encrypted = JSON.parse(File.read(path), symbolize_names: true)
      Privacy::DataDecryption.decrypt(encrypted, 'full_backup')
    end
  end
end
