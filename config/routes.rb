Rails.application.routes.draw do
  devise_for :users, controllers: {
   omniauth_callbacks: 'users/omniauth_callbacks',
   registrations: 'users/registrations'
 }
 
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  
  root to: "reviews#index"
  resources :reviews do
    collection do
      get 'search'
    end
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end
  
end
