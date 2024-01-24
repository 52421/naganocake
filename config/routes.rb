Rails.application.routes.draw do
 root 'public/homes#top'
 get '/about', to: 'public/homes#about', as: 'customer_about'
  
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
  namespace :admin do
    get '/' => 'homes#top'
    resources :items,only:[:index, :create, :new, :show, :edit, :update] 
    resources :genres, only:[:index, :edit, :create, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :orders, only:[:index, :show, :update] 
    resources :order_items, only:[:update]
  end

  scope module: :public do
    get '/about' => 'homes#about'
    get '/customers/my_page' => "customers#show", as: "my_page"
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :items, only:[:index,:show,:new] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    get :search, on: :collection # ジャンル検索機能用
    end
    resources :cart_items, only:[:index, :update, :destroy, :create] 
    post '/orders/session' => 'orders#session_create'
    get '/orders/confirm' => 'orders#confirm'
    post '/orders/confirm' => 'orders#confirm'
    get 'orders/complete' => "orders#complete"
    patch 'customers/withdraw' => "customers#withdraw"
    get 'customers/unsubscribe' => "customers#unsubscribe"
    get 'customers/favorite' => "customers#favorite"
    resources :orders, only:[:new,:create,:index,:show]
    patch '/customers/information' => "customers#update"
    get '/customers/information/edit' => "customers#edit"
    resources :addresses, only:[:index, :edit, :destroy, :create, :update]
  end
 end


