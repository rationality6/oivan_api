Rails.application.routes.draw do
  scope module: :v1, path: '/api/v1' do
    devise_for :users, skip: %i[sessions registrations]

    namespace :users do
      as :user do
        post :sign_in, to: 'sessions#create', as: :user_session
        delete :sign_out, to: 'sessions#destroy', as: :destroy_user_session
      end
    end

    get '/pings', to: 'pings#index'

    resources :admins
    resources :tests
    resources :questions, only: [:create, :destroy]
    resources :options, only: [:create, :destroy]
  end

end
