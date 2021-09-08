Rails.application.routes.draw do
  root 'products#index'
  resource :store do
    resources :products, only: [] do
      collection do
        get 'list', to: 'stores#products_list'
        get 'new', to: 'products#new'
      end
      member do
        get 'detail', to: 'stores#product_detail'
      end
    end

    resources :orders, only: [] do
      collection do
        get 'list', to: 'stores#orders_list'
      end
      member do
        get 'detail', to: 'stores#order_detail'
      end
      
    end
  end

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }
  resources :products

  resource :cart, only:[:show, :destroy] do
    collection do
      post :add, path:'add/:id'
      get :checkout, to: 'orders#checkout'
      post :confirmation, to: 'carts#confirm'
    end
  end

  resources :orders, only:[:index, :show, :create] do
    collection do
      post :response, to: 'payments#notify_response'
    end
    member do
      get :payment, to: 'payments#payment'
    end
  end



  get 'hello_world', to: 'hello_world#index'
end

