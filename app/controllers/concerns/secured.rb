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

  def user_sso(event_id)
    current_user.sso_identities.find_by(provider: 'event', event_id: event_id)
  end

  def authenticate_request_v2!
    @payload = payload
    blacklist = JwtBlacklist.find_by(jti: payload['jti'], user_id: user_id)

    raise NoJwtBlackListError unless blacklist.present?
    raise JWT::ExpiredSignature if blacklist.exp < Time.zone.now
    return true
  rescue JWT::VerificationError, JWT::DecodeError, JWT::ExpiredSignature, JWT::InvalidJtiError, NoJwtBlackListError => e
    return false
  end

  def authenticate_request!
    @payload = payload
    raise NoUserError unless current_user.present?

    blacklist = JwtBlacklist.find_by(jti: payload['jti'], user_id: user_id)
    raise NoJwtBlackListError unless blacklist.present?
    raise JWT::ExpiredSignature if blacklist.exp < Time.zone.now

  rescue JWT::VerificationError, JWT::DecodeError, JWT::ExpiredSignature, JWT::InvalidJtiError, NoJwtBlackListError => e
    render json: { errors: "Not Authenticated: #{e}" }, status: :unauthorized
  end

  def http_token
    if request.headers['Authorization'].present?
      request.headers['Authorization'].split(' ').last
    else
      cookies[:access_token]
    end
  end

  def payload
    JWT.decode(http_token,
               Devise::JWT.config.secret,
               true,
               algorithm: 'HS256',
               verify_jti: true)[0]
  end


end
