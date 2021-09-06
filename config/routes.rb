Rails.application.routes.draw do

  resources :products


  get 'hello_world', to: 'hello_world#index'

  resource :store, only: [] do
    collection do
      get "products/new", to: "products#new"
    end
  end






  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

