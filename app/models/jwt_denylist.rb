class JwtDenylist < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Denylist

  def self.jwt_revoked?(payload, _user)
    self
      .exists?(['jti = ? AND exp <= ? AND user_id = ?', payload['jti'], Time.current, _user.id])
  end

  def self.revoke_jwt(payload:, user_id:)
    self
      .find_by(jti: payload['jti'], user_id: user_id)
      .update(exp: Time.zone.now)
  end
end
