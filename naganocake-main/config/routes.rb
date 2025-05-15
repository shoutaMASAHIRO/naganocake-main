Rails.application.routes.draw do
  # 顧客用
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: "homes#top"
    get 'about', to: 'homes#about'
    get 'customers', to: 'redirects#customers'

    # customer
    get 'customers/my_page' => 'customers#show', as: 'my_page'
    get 'customers/information/edit' => 'customers#edit', as: 'edit_customer'
    patch 'customers/information' => 'customers#update', as: 'update_customer'
    get 'customers/withdraw' => 'customers#withdraw', as: 'withdraw'
    patch 'customers/withdraw_update' => 'customers#withdraw_update', as: 'withdraw_update'

    # item
    resources :items, only: [:index, :show]

    # cart_item
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete 'destroy_all', to: 'cart_items#destroy_all', as: 'delete_all'
      end
    end

    # address
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]

    # order
    resources :orders, only: [:index, :new, :create, :show] do
      collection do
        post 'check', to: 'orders#check', as: 'check'
        get 'complete', to: 'orders#complete', as: 'complete'
      end
    end
  end

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  get 'admin' => 'admin/homes#top', as: 'admin'

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update] do
      member do
        patch :toggle_status  
      end
      resources :addresses, only: [:index, :show, :edit, :update, :create, :destroy]
      resources :orders, only: [:index, :show]  # 会員に紐づく注文履歴
    end

    resources :genres, only: [:index, :create, :edit, :update]

    resources :items, only: [:new, :index, :create, :edit, :update, :show] do
      member do
        patch :toggle_status  # ← 商品の販売ステータス切り替え
      end
    end

    resources :orders, only: [:index, :show, :update]
    resources :order_details, only: [:update]
  end
end
