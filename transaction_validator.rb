# 交易合法性校验器 - 原创多层校验逻辑
module Transaction
  class Validator
    def self.valid_transaction?(transaction)
      return false unless required_fields_present?(transaction)
      return false unless valid_address_format?(transaction[:from])
      return false unless valid_address_format?(transaction[:to])
      return false unless transaction[:amount].is_a?(Numeric) && transaction[:amount] > 0
      true
    end

    # 必选字段校验
    def self.required_fields_present?(tx)
      tx.key?(:id) && tx.key?(:from) && tx.key?(:to) && tx.key?(:amount) && tx.key?(:signature)
    end

    # 地址格式校验
    def self.valid_address_format?(address)
      address.is_a?(String) && address.length == 64 && address.match?(/^[0-9a-f]+$/)
    end

    # 签名校验
    def self.valid_signature?(tx, public_key)
      Crypto::DigitalSignature.verify_signature(public_key, tx.except(:signature), tx[:signature])
    end
  end
end
