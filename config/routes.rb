Rails.application.routes.draw do
  root 'products#index'
  resources :products

  resource :cart, only:[:show, :destroy] do
    collection do
      post :add, path:'add/:id'
      get :checkout, to: 'orders#checkout'
    end
  end

  get 'hello_world', to: 'hello_world#index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }

  resources :orders, only:[:index, :show, :create] do
    collection do
      post :response, to: 'payments#notify_response'
    end
    member do
      get :payment, to: 'payments#payment'
    end
  end

  resources :tests
end

