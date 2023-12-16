Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  get  'admin' => 'admin/home#top'
  namespace :admin do
  	resources :items, only:[:new, :create, :index, :show, :edit, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :genres, only:[:index, :create, :edit, :update]
    resources :order_items, only: [:update]
	end
  get  'items' => 'public/items#index', as: "customer_items"
  get  'items/:id' => 'public/items#show', as: "customer_item"
  get 'cart_items' => 'public/cart_items#index', as: "cart_items"
  post 'cart_items' => 'public/cart_items#create'
  patch 'cart_items/:id' => 'public/cart_items#update',as: "cart_item"
  delete 'cart_items/:id' => 'public/cart_items#destroy', as: "destroy_cart_item"
  delete 'cart_items' => 'public/cart_items#destroy_all', as: "destroy_cart_items"

  get "admin/orders" => "admin/orders#index", as: "admin_orders"
  get "admin/orders/:id" => "admin/orders#show", as: "admin_order"
  patch "admin/orders/:id" => "admin/orders#update"
  get '/search' => 'search#search'

  get "orders/new" => "public/orders#new"
  get "orders/confirm" => "public/orders#confirm"
  post "orders/confirm" => "public/orders#create"
  get "thanks" => "public/orders#thanks"
  get "orders" => "public/orders#index", as: "customer_orders"
  get "orders/:id" => "public/orders#show", as: "customer_order"
  get "about" => "customer/home#about"
  patch "public/:id/quit" => "customer/customers#invalid", as: "invalid_customer"

  scope module: 'public' do
      root 'homes#top'
      get '/customers/my_page' => "customers#show", as: "my_page"

      
      resources :addresses
      
      resources :orders
      post 'orders/thanks' => 'orders#thanks'
     
    resources :'mailing_addresses', only:[:index, :create, :edit, :update, :destroy]
  end
end
