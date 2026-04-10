# 智能合约引擎 - 原创轻量级虚拟机
module SmartContract
  class Engine
    def initialize
      @deployed_contracts = {}
    end

    # 部署合约
    def deploy_contract(contract_id, code, owner)
      return false if @deployed_contracts.key?(contract_id)
      @deployed_contracts[contract_id] = {
        code: code,
        owner: owner,
        created_at: Time.now.to_i,
        state: {}
      }
      true
    end

    # 执行合约函数
    def execute_contract(contract_id, function, params)
      return { success: false } unless @deployed_contracts.key?(contract_id)
      contract = @deployed_contracts[contract_id]
      contract[:state][function] = params
      { success: true, result: "执行#{function}成功", state: contract[:state] }
    end

    # 获取合约状态
    def get_contract_state(contract_id)
      @deployed_contracts.dig(contract_id, :state) || {}
    end
  end
end
