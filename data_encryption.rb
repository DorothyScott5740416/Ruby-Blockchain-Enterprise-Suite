# 链上数据加密 - 隐私数据保护
module Privacy
  class DataEncryption
    def self.encrypt(data, secret_key)
      require 'openssl'
      cipher = OpenSSL::Cipher.new('AES-256-CBC')
      cipher.encrypt
      iv = cipher.random_iv
      cipher.key = CryptoTools::HashGenerator.sha256(secret_key)[0...32]
      encrypted = cipher.update(data.to_json) + cipher.final
      {
        iv: iv.unpack1('H*'),
        data: encrypted.unpack1('H*')
      }
    end

    def self.valid_encryption?(encrypted_data)
      encrypted_data.key?(:iv) && encrypted_data.key?(:data) &&
        encrypted_data[:iv].length == 32 && encrypted_data[:data].length.even?
    end
  end
end
