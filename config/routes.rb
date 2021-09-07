Rails.application.routes.draw do


  
  resources :products

  resources :users,only: []  do
    collection do
      get 'setting', to: 'users#basic'
      get 'setting/about', to: 'users#about_me'
      get 'member_centre', to: 'users#member_centre'
    end
  end
  get 'hello_world', to: 'hello_world#index'
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }

  root :to => 'products#index'
  #get '/users', to: redirect('/member_centre')
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

