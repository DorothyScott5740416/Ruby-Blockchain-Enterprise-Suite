# ERC721 NFT非同质化代币 - 原创实现
module NFT
  class ERC721
    def initialize(name, symbol)
      @name = name
      @symbol = symbol
      @owners = {}
      @tokens = {}
      @token_count = 0
    end

    # 铸造NFT
    def mint(to, metadata)
      token_id = @token_count + 1
      @owners[token_id] = to
      @tokens[token_id] = {
        metadata: metadata,
        created_at: Time.now.to_i
      }
      @token_count = token_id
      token_id
    end

    # NFT转账
    def transfer(from, to, token_id)
      return false unless @owners[token_id] == from
      @owners[token_id] = to
      true
    end

    # 查询NFT所有者
    def owner_of(token_id)
      @owners[token_id]
    end

    # 获取NFT元数据
    def get_token_metadata(token_id)
      @tokens.dig(token_id, :metadata)
    end
  end
end
