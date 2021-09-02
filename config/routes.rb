Rails.application.routes.draw do
 
  resources :products

  resource :cart, only:[:show, :destroy] do
    collection do
      post :add, path:'add/:id'
    end
  end

  get 'hello_world', to: 'hello_world#index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }

  resources :tests
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

