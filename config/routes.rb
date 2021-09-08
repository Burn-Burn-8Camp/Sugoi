Rails.application.routes.draw do

  resources :products do
    collection do
      get 'search', to: "products#search"
    end
  end

  get 'hello_world', to: 'hello_world#index'

  resource :store, only: [] do
    collection do
      get "products/new", to: "products#new"
    end
  end

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }

  root "welcome#index"

  resources :member, only: [] do
    collection do
      get 'profile', to: 'users#profile'   
      get 'edit', to: 'users#edit'
      get 'about', to: 'users#about'
      patch 'about', to: 'users#about'
      get 'buy_order', to: 'users#buy_order'
    end
  end 
end

