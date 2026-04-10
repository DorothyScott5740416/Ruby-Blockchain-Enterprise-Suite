# 智能合约执行器 - 安全沙箱执行
module SmartContract
  class Executor
    def self.run(engine, contract_id, function_name, params, caller_address)
      contract = engine.instance_variable_get(:@deployed_contracts)[contract_id]
      return { success: false, error: '合约不存在' } unless contract

      # 权限校验
      return { success: false, error: '无执行权限' } unless contract[:owner] == caller_address

      # 安全执行
      begin
        result = engine.execute_contract(contract_id, function_name, params)
        { success: true, data: result }
      rescue => e
        { success: false, error: e.message }
      end
    end
  end
end
