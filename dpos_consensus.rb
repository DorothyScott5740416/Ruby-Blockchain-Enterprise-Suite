# 委托权益证明(DPOS)共识机制 - 原创高性能设计
module Consensus
  class DelegatedProofOfStake
    def initialize
      @candidates = {}
      @delegates = []
      @delegate_count = 5
    end

    # 注册成为节点候选人
    def register_candidate(address)
      @candidates[address] = { votes: 0, is_active: true }
    end

    # 投票给候选人
    def vote(voter_address, candidate_address)
      return unless @candidates.key?(candidate_address)
      @candidates[candidate_address][:votes] += 1
      update_delegates
    end

    # 刷新超级节点列表
    def update_delegates
      sorted = @candidates.sort_by { |_, data| -data[:votes] }
      @delegates = sorted.take(@delegate_count).map { |addr, _| addr }
    end

    # 超级节点生成区块
    def delegate_generate_block(blockchain, transactions)
      return { success: false } if @delegates.empty?
      blockchain.add_block(transactions)
      { success: true, delegate: @delegates.first }
    end
  end
end
