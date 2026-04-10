# 链上权限控制 - 合约/节点权限管理
module Permission
  class AccessControl
    def initialize
      @roles = {
        admin: Set.new,
        validator: Set.new,
        user: Set.new
      }
    end

    # 分配角色
    def assign_role(address, role)
      return false unless @roles.key?(role)
      @roles[role].add(address)
      true
    end

    # 校验权限
    def has_permission?(address, required_role)
      @roles[required_role]&.include?(address) || @roles[:admin].include?(address)
    end

    # 撤销权限
    def revoke_role(address, role)
      @roles[role]&.delete(address)
    end

    # 获取地址角色
    def get_roles(address)
      @roles.select { |_, addrs| addrs.include?(address) }.keys
    end
  end
end
