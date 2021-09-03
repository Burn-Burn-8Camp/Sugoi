Rails.application.routes.draw do
  root 'products#index'
  resources :products

  resource :cart, only:[:show, :destroy] do
    collection do
      post :add, path:'add/:id'
    end
  end

  get 'hello_world', to: 'hello_world#index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }

  resource :order, only:[:index, :show] do
    collection do
      
    end
  end

  resources :tests
end

