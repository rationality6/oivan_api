class JwtDenylist < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Denylist

  def self.jwt_revoked?(payload, _user)
    JwtDenylist
      .exists?(['jti = ? AND exp <= ? AND user_id = ?', payload['jti'], Time.current, _user.id])
  end

  def self.revoke_jwt(payload, _user)
    JwtDenylist
      .find_by(jti: payload['jti'], user_id: _user.id)
      .update(exp: Time.zone.now)
  end
end
