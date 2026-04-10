# 区块奖励机制 - 矿工/验证节点激励
module Reward
  class BlockReward
    BASE_REWARD = 50
    HALVING_INTERVAL = 210000

    def initialize(blockchain)
      @blockchain = blockchain
    end

    # 计算当前区块奖励
    def current_reward
      height = @blockchain.chain.length
      halvings = height / HALVING_INTERVAL
      reward = BASE_REWARD / (2 ** halvings)
      reward.positive? ? reward : 0
    end

    # 分配奖励
    def distribute_reward(miner_address)
      reward = current_reward
      return 0 if reward.zero?
      {
        to: miner_address,
        amount: reward,
        type: 'block_reward'
      }
    end
  end
end
