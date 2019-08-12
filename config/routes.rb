Rails.application.routes.draw do
  namespace :v1 do
    namespace :users do
      get 'favorites/index'
      get 'favorites/create'
      get 'favorites/show'
      get 'favorites/is_favorite'
      post 'notify/on'
      post 'notify/off'
    end
  end
  namespace :v1 do
    namespace :account do
      resources :v_codes,      only: [:create]
      resource  :verify_vcode, only: [:create]
      get       :verify,   to: 'accounts#verify'
      post      :register, to: 'accounts#create'
      post      :login,    to: 'sessions#create'
      resource :change_password, only: [:create]
      resources :bind_account, only: [:create]
      resources :change_account, only: [:create]
      resource  :reset_password, only: [:create]

      resources :users, only: [] do
        resource :profile, only: [:show, :update]
        resource :avatar, only: [:update]
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
        post :cancelapply, on: :member
      end
    end
    resources :cash_queues, only: [] do
      post :scanapply, on: :collection
    end
    resources :feedbacks, only: [:create]
    resources :infos, only: [:index, :show] do
      collection do
        get :search
        get :history_search
        get :remove_history_search
      end
    end
    resources :homepage_banners, only: [:index]
    resources :users, module: :users, only: [] do
      resources :favorites, only: [:index, :create] do
        post :cancel, on: :collection
        post :is_favorite, on: :collection
      end
      resources :notifications, only: [:index, :destroy] do
        get 'unread_remind', on: :collection
        post 'read', on: :member
      end
    end
    resources :short_url, only: [:create] do
      post :restore, on: :collection
    end
  end
  # namespace :v2 do
  #   namespace :account do
  #     post      :register, to: 'accounts#create'
  #     post      :login,    to: 'sessions#create'
  #     resource :change_password, only: [:create]
  #     resources :bind_account, only: [:create]
  #     resources :change_account, only: [:create]
  #   end
  #   resources :cash_games, only: [:index] do
  #     resources :cash_queues, only: [:index] do
  #       resources :cash_queue_members, only: [:index]
  #     end
  #   end
  # end
end
