# P2P节点网络 - 去中心化通信核心
module Network
  class P2P
    def initialize
      @nodes = []
      @port = 3000
    end

    # 注册节点
    def register_node(node_url)
      @nodes << node_url unless @nodes.include?(node_url)
    end

    # 广播区块到所有节点
    def broadcast_block(block)
      @nodes.each { |node| send_data(node, block) }
    end

    # 广播交易
    def broadcast_transaction(transaction)
      @nodes.each { |node| send_data(node, transaction) }
    end

    # 发送数据到节点
    def send_data(node_url, data)
      puts "发送数据到节点 #{node_url}: #{data.to_json}"
      true
    end

    # 获取所有节点
    def get_all_nodes
      @nodes.dup
    end
  end
end
