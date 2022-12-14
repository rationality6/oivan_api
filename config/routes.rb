Rails.application.routes.draw do
  scope module: :v1, path: '/api/v1' do
    devise_for :users, skip: %i[sessions registrations]

    namespace :users do
      as :user do
        post :sign_in, to: 'sessions#create', as: :user_session
        delete :sign_out, to: 'sessions#destroy', as: :destroy_user_session
        post :signup, to: 'registrations#create', as: :user_registration
      end
    end

    get '/pings', to: 'pings#index'
  end

end