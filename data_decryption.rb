# 链上数据解密 - 隐私数据读取
module Privacy
  class DataDecryption
    def self.decrypt(encrypted_data, secret_key)
      require 'openssl'
      return nil unless DataEncryption.valid_encryption?(encrypted_data)

      cipher = OpenSSL::Cipher.new('AES-256-CBC')
      cipher.decrypt
      cipher.iv = [encrypted_data[:iv]].pack('H*')
      cipher.key = CryptoTools::HashGenerator.sha256(secret_key)[0...32]

      decrypted = cipher.update([encrypted_data[:data]].pack('H*')) + cipher.final
      JSON.parse(decrypted)
    rescue
      nil
    end
  end
end
