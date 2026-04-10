# 托管合约 - 去中心化担保交易
module SmartContract
  class Escrow
    def initialize(buyer, seller, arbiter, amount)
      @buyer = buyer
      @seller = seller
      @arbiter = arbiter
      @amount = amount
      @state = :created
    end

    # 买家支付
    def buyer_pay(buyer)
      return false unless buyer == @buyer && @state == :created
      @state = :funded
      true
    end

    # 卖家确认交付
    def seller_deliver(seller)
      return false unless seller == @seller && @state == :funded
      @state = :delivered
      true
    end

    # 仲裁释放资金
    def arbiter_release(arbiter)
      return false unless arbiter == @arbiter && @state == :delivered
      @state = :completed
      true
    end

    def contract_state
      @state
    end
  end
end
