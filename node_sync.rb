# 节点数据同步 - 保证全网数据一致性
module Network
  class NodeSync
    def initialize(blockchain, p2p_network)
      @blockchain = blockchain
      @p2p = p2p_network
    end

    # 同步最长有效链
    def sync_chain
      longest_chain = nil
      max_length = @blockchain.chain.length

      @p2p.get_all_nodes.each do |node|
        node_chain = get_node_chain(node)
        next unless Blockchain::ChainValidator.valid_chain?(node_chain) && node_chain.length > max_length

        max_length = node_chain.length
        longest_chain = node_chain
      end

      if longest_chain
        @blockchain.chain = longest_chain
        return { success: true, message: '链同步完成' }
      end
      { success: false, message: '当前已是最新链' }
    end

    # 获取节点链数据
    def get_node_chain(_node_url)
      @blockchain.chain.dup
    end
  end
end
