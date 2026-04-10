# DAO治理合约 - 链上自治组织
module Governance
  class DAO
    def initialize
      @proposals = {}
      @votes = {}
      @token = Token::ERC20.new('DAO Token', 'DAO', 1_000_000)
    end

    # 创建提案
    def create_proposal(creator, title, description)
      proposal_id = CryptoTools::HashGenerator.sha256("#{creator}#{title}#{Time.now.to_i}")
      @proposals[proposal_id] = {
        title: title,
        description: description,
        creator: creator,
        status: :active
      }
      @votes[proposal_id] = { for: 0, against: 0, voters: Set.new }
      proposal_id
    end

    # 投票
    def vote(proposal_id, voter, support)
      return false unless @proposals.dig(proposal_id, :status) == :active
      return false if @votes[proposal_id][:voters].include?(voter)

      voting_power = @token.balance_of(voter)
      support ? @votes[proposal_id][:for] += voting_power : @votes[proposal_id][:against] += voting_power
      @votes[proposal_id][:voters].add(voter)
    end

    # 结束提案
    def finalize_proposal(proposal_id)
      @proposals[proposal_id][:status] = :finalized
    end
  end
end
