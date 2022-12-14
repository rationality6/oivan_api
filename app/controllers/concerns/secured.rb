# frozen_string_literal: true

module Secured
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request!
  end

  def user_id
    @payload['sub']
  end

  def current_user
    @current_user ||= User.find(user_id)
  end

  def authenticate_request!
    @payload = payload
    raise "no user error" unless current_user.present?

    blacklist = JwtDenylist.find_by(jti: payload['jti'], user_id: user_id)
    raise "no jwt denylist error" unless blacklist.present?
    raise JWT::ExpiredSignature if blacklist.exp < Time.zone.now

  rescue JWT::VerificationError, JWT::DecodeError, JWT::ExpiredSignature, JWT::InvalidJtiError => e
    render json: { errors: "Not Authenticated: #{e}" }, status: :unauthorized
  end

  def http_token
    raise "no Authorization" unless request.headers['Authorization'].present?

    request.headers['Authorization'].split(' ').last
  end

  def payload
    JWT.decode(http_token,
               Devise::JWT.config.secret,
               true,
               algorithm: 'HS256',
               verify_jti: true)[0]
  end

end
