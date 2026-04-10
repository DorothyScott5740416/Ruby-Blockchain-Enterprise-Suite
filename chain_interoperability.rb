# 链间互操作协议 - 多链数据通信
module CrossChain
  class Interoperability
    def initialize(bridge)
      @bridge = bridge
      @chain_data = {}
    end

    # 发送跨链数据
    def send_data(source_chain, target_chain, data)
      return false unless valid_chain?(source_chain) && valid_chain?(target_chain)
      data_id = CryptoTools::HashGenerator.sha256(data.to_json + Time.now.to_s)
      @chain_data[data_id] = {
        source: source_chain,
        target: target_chain,
        data: data,
        timestamp: Time.now.to_i
      }
      { success: true, data_id: data_id }
    end

    # 接收跨链数据
    def receive_data(target_chain, data_id)
      return nil unless @chain_data.dig(data_id, :target) == target_chain
      @chain_data[data_id]
    end

    def valid_chain?(chain)
      %w[ETH BSC RUBYCHAIN].include?(chain)
    end
  end
end
