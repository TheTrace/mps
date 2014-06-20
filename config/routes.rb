Mps::Application.routes.draw do
  get "users/new"
  resources :template_tasks do
    collection do
      post :sort_templates
    end
  end

  resources :contacts

  resources :notes

  resources :tasks do
    member do
      post :complete_a
      post :complete_b
      post :complete
    end
  end

  resources :jobs do
    member do
      get :finance
      get :contacts
    end
    collection do
      get :tasklist
    end
  end

  resources :finances

  resources :users

  resources :sessions, only: [:new, :create, :destroy]

  #match "/signup", to: "users#new", via: "get"
  match "/signin", to: "sessions#new", via: "get"
  match "/signout", to: "sessions#destroy", via: "delete"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'jobs#index'

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
  match '/', to: 'jobs#index', via: 'get'
end
