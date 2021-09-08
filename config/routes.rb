Rails.application.routes.draw do
  resources :products

  get 'hello_world', to: 'hello_world#index'

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


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

