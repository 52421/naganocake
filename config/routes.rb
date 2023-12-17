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
    get '/admins' => 'admins#top'
    resources :items
    resources :genres
    resources :members
    resources :orders,only:[:index,:show,:update]
    resources :order_items, only:[:update]
  end

  scope namespace :public do
    get '/about' => 'homes#about'
    get '/customers/my_page' => "customers#show", as: "my_page"
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :items, only:[:index,:show,:new] do
        get :search, on: :collection # ジャンル検索機能用
    end
    resources :cart_items
    post '/orders/session' => 'orders#session_create'
    get '/orders/confirm' => 'orders#confirm'
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/thanks' => 'orders#thanks'
    patch '/members/withdrawal' => 'members#destroy'
    get '/members/withdrawal' => 'members#withdrawal'
    resources :orders, only:[:new,:create,:index,:show]
    resource :members, only:[:show ,:edit,:update]
    resources :addresses, only:[:index, :edit, :destroy, :create, :update]
  end
 end
