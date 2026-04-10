# 多签钱包 - 多重签名交易
module Wallet
  class MultiSignature
    def initialize(required_signatures, owners)
      @required = required_signatures
      @owners = Set.new(owners)
      @signatures = {}
    end

    # 签名交易
    def sign_transaction(signer_address, transaction)
      return false unless @owners.include?(signer_address)
      @signatures[signer_address] = true
      true
    end

    # 校验是否满足多签条件
    def ready_to_execute?
      @signatures.length >= @required
    end

    # 执行多签交易
    def execute(transaction)
      return false unless ready_to_execute?
      { success: true, transaction: transaction, signatures: @signatures.length }
    end

    def reset
      @signatures = {}
    end
  end
end
