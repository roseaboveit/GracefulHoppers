GracefulHoppers::Application.routes.draw do
  #devise_for :users

  post '/auth/:provider/callback' => 'session#create'
  get '/auth/:provider/callback'  => 'session#create'
  
  get "welcome/index"
  get "/research" => 'welcome#research', as: :research
  
  resources :users, :units, :lessons, :segments
  resources :session, only: [:new, :create, :destroy]
  resources :completed_lessons, only: [:create]

  get "/admin/:id", to: "users#admin", as: :admin_dashboard

  patch "/users/:id/edit", to: "users#adminify", as: :adminify
  patch "/units/:id", to: "users#level_up", as: :level_up
  patch "/units/:id/edit", to: "units#publish", as: :publish

  match '/signup', to: 'users#new', via: :get
  match '/signin', to: 'session#new', via: [:get, :post], as: :signin
  match '/signout', to: 'session#destroy', via: [:get, :delete], as: :signout

  post "/lessons/:id/", to: "users#complete_lesson", as: :completed_lesson

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
