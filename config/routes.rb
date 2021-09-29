Rails.application.routes.draw do
  resources :messages, only: %i[create index]

  resources :rooms, expect: %i[destroy edit]  do
    collection do
      get 'rooms',to: 'rooms/index'
    end
  end
  
  root "products#index"
  resource :store do
    collection do
      get 'application', to: 'sellers#new'
      patch 'seller_apply', to: 'sellers#update'
      get "verify", to: 'sellers#verify'
      post "seller_verify", to: 'sellers#seller_verify'
      get 'verified', to: 'sellers#verified'
    end
    
    resources :products, only: [] do
      collection do
        get 'list', to: 'stores#products_list'
        patch 'list',to:'stores#update'
        patch 'list',to:'stores#destory'
        get 'new', to: 'products#new'
        patch 'new',to:'products#update'
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
        get 'shipment', to: 'stores#shipment'
      end
      resource :comment, only: [] do
        post 'create', to: 'comments#seller_comment'
      end
    end
  end

  resource :cart, only:[:show, :destroy] do
    collection do
      post :add_item, path:'add_item/:id'
      post :delete_item, to: "carts#delete_item"
      get :checkout, to: 'orders#checkout'
      post :confirmation, to: 'carts#confirm'
      post :redeem, to: 'carts#redeem'
      post :delete_item, to: 'carts#confirm'
    end
  end

  resources :orders, only:[:index, :show, :create] do
    collection do
      post :response, to: 'payments#notify_response'
      get :pending, to: 'orders#pending'
      get :processing, to: 'orders#processing'
      get :shipped, to: 'orders#shipped'
      get :completed, to: 'orders#completed'
      get :cancelled, to: 'orders#cancelled'
    end
    member do
      get :payment, to: 'payments#payment'
      post :items_info, to: 'orders#items_info'
      patch :cancel, to: 'orders#cancel_order'
    end
  end

  resources :products do
    collection do
      get 'search', to: "products#search"
    end
    member do
      post :favorite
    end
  end

  resources :order_items, only: [] do
    resource :comment, only: [] do
      post 'create', to: 'comments#buyer_comment'
    end
  end

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }
  devise_scope :users do
    resources :member, only: [] do
      collection do
        get 'profile', to: 'users#profile'
        get 'edit', to: 'users#edit'
        patch 'edit',to:'users#update'
        get 'about', to: 'users#about'
        patch 'about', to: 'users#update'
        get 'buy_order', to: 'users#buy_order'
        get 'favorite', to: 'users#favorite'
        get 'user_coupons', to: 'users#user_coupons'
        get 'dialog', to: 'users#dialog'
      end
    end
  end 

  resources :coupons do 
    member do
      post 'get', to: 'coupons#get'
    end
  end  
end

