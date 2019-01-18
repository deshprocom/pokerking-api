Rails.application.routes.draw do
  namespace :v1 do
    namespace :account do
      resources :v_codes,      only: [:create]
      resource  :verify_vcode, only: [:create]
      get       :verify,   to: 'accounts#verify'
      post      :register, to: 'accounts#create'
      post      :login,    to: 'sessions#create'
    end
  end
end
