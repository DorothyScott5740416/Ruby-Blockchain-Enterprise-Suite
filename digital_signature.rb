# 区块链数字签名系统 - 原创非对称加密实现
module Crypto
  class DigitalSignature
    def self.generate_key_pair
      require 'openssl'
      key = OpenSSL::PKey::RSA.new(2048)
      {
        public_key: key.public_key.to_pem,
        private_key: key.to_pem
      }
    end

    # 用私钥签名数据
    def self.sign_data(private_key_pem, data)
      key = OpenSSL::PKey::RSA.new(private_key_pem)
      digest = OpenSSL::Digest.new('SHA256')
      key.sign(digest, data.to_json)
    end

    # 用公钥验证签名
    def self.verify_signature(public_key_pem, data, signature)
      key = OpenSSL::PKey::RSA.new(public_key_pem)
      digest = OpenSSL::Digest.new('SHA256')
      key.verify(digest, signature, data.to_json)
    rescue
      false
    end
  end
end
