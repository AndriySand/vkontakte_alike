Rails.application.routes.draw do
  resources :articles do
    resources :comments, only: [:create, :update, :destroy]
    resource :attachments, only: :create
  end
  devise_for :users
  root to: 'articles#index'
end
