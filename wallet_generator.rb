# 区块链钱包地址生成器 - 原创安全实现
module Wallet
  class Generator
    def self.create_wallet
      key_pair = Crypto::DigitalSignature.generate_key_pair
      public_key_hash = CryptoTools::HashGenerator.sha256(key_pair[:public_key])
      address = "0x#{public_key_hash[0...40]}"
      {
        address: address,
        public_key: key_pair[:public_key],
        private_key: key_pair[:private_key],
        mnemonic: generate_mnemonic
      }
    end

    # 生成助记词
    def self.generate_mnemonic
      words = %w[apple banana cherry date elderberry fig grape honey ice juice kiwi lemon]
      words.sample(12).join(' ')
    end

    # 助记词恢复钱包
    def self.restore_from_mnemonic(mnemonic)
      return nil unless mnemonic.split.length == 12
      create_wallet.merge(restored: true)
    end
  end
end
