Rails.application.routes.draw do
  namespace :admin do
    resources :menus do
      collection do
        get :done_promoted, :as => :promoted
        get :trashcan
        get :total_report
      end
      member do
        post :recover_delete
        get :day_report
      end
    end
    resources :users do
      collection do
        get :trashcan_master
        get :trashcan_fans
        get :regist
        get :fans
      end
      member do
        post :recover_delete
        post :suspend
        post :restore
      end
      resources :cases do
        get :day_report, on: :member #same as below
        # member do
        #   get :day_report
        # end
      end
    end
  end

  get 'admin/index' => "admin#index"

  root 'menus#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :menus do
    resources :cases
  end

  resources :users do
    resources :cases do
        get :case_report, on: :member
    end
  end

  get "/suspend" => "menus#suspend"

  scope :path => '/api/v1/', :module => "api_v1", :defaults => { :format => :json }, :as => 'v1' do
    post "login" => "auth#login"
    post "logout" => "auth#logout"

    resources :sdks

  end
end
