# 区块链安全存储 - 密钥/数据加密存储
module Storage
  class SecureStorage
    def self.save(data, filename, password)
      encrypted = Privacy::DataEncryption.encrypt(data, password)
      File.write(filename, encrypted.to_json)
      true
    end

    def self.load(filename, password)
      return nil unless File.exist?(filename)
      encrypted = JSON.parse(File.read(filename), symbolize_names: true)
      Privacy::DataDecryption.decrypt(encrypted, password)
    end

    def self.backup_wallet(wallet, password)
      save(wallet, "#{wallet[:address]}.bak", password)
    end
  end
end
