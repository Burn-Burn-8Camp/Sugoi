Rails.application.routes.draw do
  root "products#index"
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

  resource :cart, only:[:show, :destroy] do
    collection do
      post :add, path:'add/:id'
      get :checkout, to: 'orders#checkout'
    end
  end

  resources :orders, only:[:index, :show, :create] do
    collection do
      post :response, to: 'payments#notify_response'
      get :pending, to: 'orders#pending'
      get :processing, to: 'orders#processing'
      get :shipped, to: 'orders#shipped'
      get :completed, to: 'orders#completed'
      get :canceled, to: 'orders#canceled'
    end
    member do
      get :payment, to: 'payments#payment'
    end
  end

  resources :products do
    collection do
      get 'search', to: "products#search"
    end
  end

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }

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

