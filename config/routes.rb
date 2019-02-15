Rails.application.routes.draw do
  namespace :v1 do
    namespace :account do
      resources :v_codes,      only: [:create]
      resource  :verify_vcode, only: [:create]
      get       :verify,   to: 'accounts#verify'
      post      :register, to: 'accounts#create'
      post      :login,    to: 'sessions#create'

      resources :users, only: [] do
        resource :profile, only: [:show, :update]
      end
    end
    resources :main_events, only: [:index, :show] do
      get 'recent_events', on: :collection

      resources :infos, only: [:index, :show], controller: 'event_infos'
      resources :schedules, only: [:index] do
        get 'dates', on: :collection
      end
    end
    resources :cash_games, only: [:index] do
      resources :cash_queues, only: [:index] do
        resources :cash_queue_members, only: [:index]
      end
    end
    resources :feedbacks, only: [:create]

    resources :infos, only: [:index, :show]
    resources :homepage_banners, only: [:index]
  end
end
