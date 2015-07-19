Rails.application.routes.draw do
  namespace :admin do
    resources :users do
      collection do
        post :trashcan
        get :regist
      end
      member do
        post :recover_delete
      end
      resources :cases do
        member do
          get :day_report
        end
      end
    end
  end
  namespace :admin do
    resources :menus do
      member do
        get :total_report
        get :day_report
      end
    end
  end
  # devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'menus#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # devise_for :users, :controllers => { :registrations => "my_devise/registrations" }

  resources :menus do
    resources :cases
  end

  resources :users do

    member do
      post :suspend
      post :restore
    end
    resources :cases
  end

  get "/suspend" => "menus#suspend"
  # devise_scope :user do
  #   get 'sign_out', :to => 'devise/sessions#destroy', :as => :des_user_session
  # end
  # devise_scope :user do
   # get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
