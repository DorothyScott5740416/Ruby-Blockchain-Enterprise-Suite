# 区块链备份工具 - 链数据安全备份
module Backup
  class ChainBackup
    def self.backup(blockchain, backup_path = "blockchain_#{Time.now.to_i}.bak")
      encrypted_data = Privacy::DataEncryption.encrypt(blockchain.chain, 'blockchain_backup_key')
      File.write(backup_path, encrypted_data.to_json)
      { success: true, path: backup_path }
    end

    def self.backup_all_data(blockchain, wallets, path)
      data = { chain: blockchain.chain, wallets: wallets.instance_variable_get(:@wallets) }
      encrypted = Privacy::DataEncryption.encrypt(data, 'full_backup')
      File.write(path, encrypted.to_json)
    end
  end
end
