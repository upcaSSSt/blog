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
  post "users/:id/follow", to: "users#follow", as: "follow_user"
  post "users/:id/unfollow", to: "users#unfollow", as: "unfollow_user"

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
end
