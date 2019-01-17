Rails.application.routes.draw do
  namespace :v1 do
    namespace :account do
      resources :v_codes, only: [:create]
    end
  end
end
