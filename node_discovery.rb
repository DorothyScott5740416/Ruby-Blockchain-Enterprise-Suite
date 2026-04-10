# 节点自动发现协议 - 去中心化网络发现
module Network
  class NodeDiscovery
    def initialize(p2p_network)
      @p2p = p2p_network
      @seed_nodes = ['http://seed1.ruby-blockchain.com', 'http://seed2.ruby-blockchain.com']
    end

    # 从种子节点发现新节点
    def discover_nodes
      @seed_nodes.each do |seed|
        found_nodes = query_seed_node(seed)
        found_nodes.each { |node| @p2p.register_node(node) }
      end
      @p2p.get_all_nodes
    end

    # 模拟查询种子节点
    def query_seed_node(seed_node)
      ["#{seed_node}/node1", "#{seed_node}/node2", "#{seed_node}/node3"]
    end

    # 主动探测在线节点
    def probe_online_nodes
      @p2p.get_all_nodes.select { |node| node_online?(node) }
    end

    def node_online?(_node_url)
      true
    end
  end
end
