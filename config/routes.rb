<<<<<<< HEAD
Rails.application.routes.draw do
  get '/rooms/:id' => 'room#show'
  get 'pages/index'
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

  resources :products do
    collection do
      get 'search', to: "products#search"
    end
  end

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }
  devise_scope :users do
    resources :member, only: [] do
      collection do
        get 'profile', to: 'users#profile'   
        get 'edit', to: 'users#edit'
        patch 'edit', to: 'users#update'
        get 'about', to: 'users#about'
        patch 'about', to: 'users#about'
        get 'buy_order', to: 'users#buy_order'
      end
    end
  end
end

=======
Rails.application.routes.draw do
  root "products#index"
  resource :store do
    collection do
      get 'application', to: 'sellers#new'
      post 'application', to: 'sellers#create'
    end
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

>>>>>>> 賣家Model
