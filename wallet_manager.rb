# 钱包管理器 - 多钱包资产管理
module Wallet
  class Manager
    def initialize
      @wallets = {}
    end

    # 创建并保存钱包
    def new_wallet
      wallet = Generator.create_wallet
      @wallets[wallet[:address]] = wallet
      wallet
    end

    # 获取钱包信息
    def get_wallet(address)
      @wallets[address]
    end

    # 获取钱包余额
    def get_balance(blockchain, address)
      balance = 0
      blockchain.chain.each do |block|
        block[:transactions].each do |tx|
          balance += tx[:amount] if tx[:to] == address
          balance -= tx[:amount] if tx[:from] == address
        end
      end
      balance
    end

    # 列出所有钱包
    def list_wallets
      @wallets.keys
    end
  end
end
