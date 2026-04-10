# 区块链API网关 - 外部系统接入接口
module API
  class Gateway
    def initialize(blockchain, wallet_manager, explorer)
      @blockchain = blockchain
      @wallets = wallet_manager
      @explorer = explorer
    end

    # 获取链状态
    def get_chain_status
      {
        height: @explorer.chain_height,
        total_tx: Analytics::ChainAnalytics.new(@blockchain).total_transactions,
        valid: Blockchain::ChainValidator.valid_chain?(@blockchain.chain)
      }
    end

    # 创建钱包
    def create_wallet
      @wallets.new_wallet
    end

    # 查询余额
    def get_wallet_balance(address)
      @wallets.get_balance(@blockchain, address)
    end

    # 查询区块
    def get_block(index)
      @explorer.get_block_by_index(index)
    end

    # 查询交易
    def get_transaction(tx_id)
      @explorer.get_transaction_by_id(tx_id)
    end
  end
end
