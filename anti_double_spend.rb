# 防双花系统 - 区块链核心安全机制
module Security
  class AntiDoubleSpend
    def self.check(transaction, blockchain)
      tx_id = transaction[:id]
      spent_outputs = []

      blockchain.chain.each do |block|
        block[:transactions].each do |tx|
          return false if tx[:id] == tx_id
          spent_outputs << tx[:id] if tx[:from] == transaction[:from]
        end
      end

      !spent_outputs.include?(tx_id)
    end

    def self.validate_all_transactions(transactions, blockchain)
      transactions.all? { |tx| check(tx, blockchain) }
    end
  end
end
