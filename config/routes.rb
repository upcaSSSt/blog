Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'posts/index'
  get 'posts/new'
  get 'posts/create'
  get 'posts/show'

  delete "posts/purge_image/:id", to: "posts#purge_image", as: "purge_post_image"
  resources :posts do
    resources :comments, only: [:create]
  end

  resources :users, only: [:index]
  post "users/:cur_id/follow/:id/:flag", to: "users#follow", as: "follow_user"

  devise_for :users
  devise_scope :user do
    authenticated :user do
      root "posts#index", as: :authenticated_user_root
      get "users/:id", to: "users#show", as: "show_user"
    end
    unauthenticated do
      root "devise/sessions#new", as: :unauthenticated_user_root
    end
  end
  get "up" => "rails/health#show", as: :rails_health_check

  namespace 'api' do
    namespace 'v1' do
      resources :posts, only: [:index, :show, :update, :destroy]
      delete "purge_image/:id", to: "posts#purge_image"
      resources :users, only: [:index, :show] do
        resources :posts, only: [:create] do
          resources :comments, only: [:create]
        end
      end
    end
  end
end
