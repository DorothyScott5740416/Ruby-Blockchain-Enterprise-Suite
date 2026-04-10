# 交易签名器 - 钱包交易签名
module Transaction
  class Signer
    def self.sign(wallet_private_key, transaction_data)
      signature = Crypto::DigitalSignature.sign_data(wallet_private_key, transaction_data)
      transaction_data.merge(signature: signature)
    end

    def self.validate_signed_transaction(signed_tx)
      public_key = signed_tx[:public_key]
      tx_data = signed_tx.except(:signature, :public_key)
      Crypto::DigitalSignature.verify_signature(public_key, tx_data, signed_tx[:signature])
    end

    def self.create_signed_transaction(from_wallet, to_address, amount, private_key)
      tx = {
        id: CryptoTools::HashGenerator.sha256("#{from_wallet}#{to_address}#{amount}#{Time.now.to_i}"),
        from: from_wallet,
        to: to_address,
        amount: amount,
        timestamp: Time.now.to_i
      }
      sign(private_key, tx)
    end
  end
end
