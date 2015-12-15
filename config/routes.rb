Rails.application.routes.draw do

  root 'channels#index'
  get "/about" => "landings#about"
  get "/recuit" => "landings#recuit"
  get "/qa" => "landings#qa"
  get "/contact" => "landings#contact"
  get "/all" => "channels#allchannels"
  get "/suspend" => "menus#suspend"
  resources :channels
  resources :feedbacks
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :menus, path: :m do
    resources :cases, path: :c
  end

  resources :users, path: :u do
    resources :cases, path: :c do
        get :case_report, on: :member
    end
    resources :deposit_records
  end

  get 'admin/index' => "admin#index"
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
        get :valueless
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


  scope :path => '/api/v1/', :module => "api_v1", :defaults => { :format => :json }, :as => 'v1' do
    post "login" => "auth#login"
    post "logout" => "auth#logout"

    resources :sdks
  end
end
