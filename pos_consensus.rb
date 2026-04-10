# 权益证明(POS)共识机制 - 原创无挖矿设计
module Consensus
  class ProofOfStake
    def initialize(blockchain)
      @blockchain = blockchain
      @validators = {}
    end

    # 质押代币成为验证节点
    def stake(address, amount)
      @validators[address] ||= 0
      @validators[address] += amount
    end

    # 根据权益选择出块节点
    def select_validator
      return nil if @validators.empty?
      total_stake = @validators.values.sum
      random_value = rand(total_stake)
      current = 0
      @validators.each do |addr, stake|
        current += stake
        return addr if current > random_value
      end
      @validators.keys.first
    end

    # 验证节点生成区块
    def generate_block(validator_address, transactions)
      return { success: false, message: '无权限' } unless @validators.key?(validator_address)
      @blockchain.add_block(transactions)
      { success: true, message: '区块生成成功' }
    end
  end
end
