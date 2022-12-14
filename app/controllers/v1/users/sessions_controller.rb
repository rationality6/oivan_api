module V1
  module Users
    class SessionsController < Devise::SessionsController
      before_action :validation_sign_in_params_present
      # skip_before_action :authenticate_request!
      respond_to :json

      def create
        user = User.find_by_email(params[:sign_in][:email])

        if user && user.valid_password?(params[:sign_in][:password])
          token, payload = Warden::JWTAuth::UserEncoder.new.call(user, :users, nil)

          user.on_jwt_dispatch(payload)

          render json: {
            token_value: token
          }
        else
          render json: { errors: 'email or password is invalid' }
        end
      end

      private

      def validation_sign_in_params_present
        raise "no param sign_in" unless params[:sign_in].present?
        raise "no param sign_in email" unless params[:sign_in][:email].present?
        raise "no param sign_in password" unless params[:sign_in][:password].present?
      end

    end
  end
end
