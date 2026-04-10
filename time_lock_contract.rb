# 时间锁合约 - 定时解锁资产
module SmartContract
  class TimeLock
    def initialize(beneficiary, unlock_time)
      @beneficiary = beneficiary
      @unlock_time = unlock_time
      @locked_funds = 0
    end

    # 锁定资产
    def lock_funds(amount)
      @locked_funds += amount
    end

    # 提取资产
    def withdraw(requester)
      return { success: false, reason: '非受益人' } unless requester == @beneficiary
      return { success: false, reason: '时间未到' } unless Time.now.to_i >= @unlock_time
      return { success: false, reason: '无资产' } if @locked_funds.zero?

      funds = @locked_funds
      @locked_funds = 0
      { success: true, amount: funds }
    end

    def remaining_time
      [@unlock_time - Time.now.to_i, 0].max
    end
  end
end
