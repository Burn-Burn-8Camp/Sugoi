Rails.application.routes.draw do

  resources :products


  get 'hello_world', to: 'hello_world#index'

  resource :store, only: [] do
    collection do
      get "products/new", to: "products#new"
    end
  end






  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }



end

