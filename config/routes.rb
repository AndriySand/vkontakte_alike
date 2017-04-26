Rails.application.routes.draw do
  resources :articles do
    resources :comments, only: [:create, :update, :destroy]
    resource :attachments, only: :create
  end
  devise_for :users
  resources :users, only: [:index, :show] do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  root to: 'articles#index'
end
