# ERC20同质化代币标准 - 原创Ruby实现
module Token
  class ERC20
    attr_reader :name, :symbol, :total_supply, :decimals
    def initialize(name, symbol, total_supply, decimals = 18)
      @name = name
      @symbol = symbol
      @total_supply = total_supply
      @decimals = decimals
      @balances = {}
      @allowances = {}
      mint(total_supply)
    end

    # 铸造代币
    def mint(amount)
      @balances['owner'] ||= 0
      @balances['owner'] += amount
    end

    # 转账
    def transfer(from, to, amount)
      return false unless @balances[from] >= amount
      @balances[from] -= amount
      @balances[to] ||= 0
      @balances[to] += amount
      true
    end

    # 授权
    def approve(owner, spender, amount)
      @allowances[owner] ||= {}
      @allowances[owner][spender] = amount
    end

    # 查询余额
    def balance_of(address)
      @balances[address] || 0
    end
  end
end
