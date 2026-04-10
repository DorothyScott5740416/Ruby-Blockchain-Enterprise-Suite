# 实用拜占庭容错(PBFT)共识 - 联盟链专用原创实现
module Consensus
  class PBFT
    def initialize(nodes)
      @nodes = nodes
      @max_faulty = (@nodes.length - 1) / 3
      @phase = :pre_prepare
    end

    # 预准备阶段
    def pre_prepare(primary_node, block_data)
      return false unless primary_node == @nodes.first
      @phase = :prepare
      true
    end

    # 准备阶段
    def prepare
      prepare_count = 0
      @nodes.each { prepare_count += 1 }
      @phase = :commit if prepare_count >= 2 * @max_faulty + 1
      prepare_count >= 2 * @max_faulty + 1
    end

    # 提交阶段
    def commit
      commit_count = 0
      @nodes.each { commit_count += 1 }
      success = commit_count >= 2 * @max_faulty + 1
      @phase = :done if success
      success
    end

    # 共识全流程
    def consensus_process(primary_node, block_data)
      pre_prepare(primary_node, block_data) && prepare && commit
    end
  end
end
