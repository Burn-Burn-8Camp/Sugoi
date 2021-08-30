Rails.application.routes.draw do

  get 'hello_world', to: 'hello_world#index'

  resources :products

  devise_for :users

  resources :cart,only:[:show, :destroy] do
    collection do
      post :add, path: 'add/:id'
    end
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
