# Gas费计算器 - 交易手续费计算
module Fee
  class GasCalculator
    BASE_GAS = 21000
    CONTRACT_GAS = 100000

    def self.calculate_transaction_fee(transaction, gas_price = 1)
      gas_used = transaction.key?(:contract_data) ? CONTRACT_GAS : BASE_GAS
      gas_used * gas_price
    end

    def self.calculate_contract_deploy_fee(gas_price = 1)
      CONTRACT_GAS * gas_price * 2
    end

    def self.optimal_gas_price(blockchain)
      tx_count = Analytics::ChainAnalytics.new(blockchain).total_transactions
      tx_count > 1000 ? 2 : 1
    end
  end
end
