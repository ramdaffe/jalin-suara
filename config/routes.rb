Mapstories::Application.routes.draw do
  match '/admin' => 'admin/home#index'
  namespace :admin do
    resources :activities
    match 'activites/import_excel' => 'activities#import_excel'
    match 'activites/empty_pnpm_data' => 'activities#empty_pnpm_data'
    resources :comments
    resources :districts
    resources :posts
    resources :provinces
    resources :roles
    resources :subdistricts
    resources :users
  end

  match 'home/search' => 'home#search'
  match 'home/show_map' => 'home#show_map'
  match 'home/about' => 'home#about'

  # devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  match 'users/auth/:service/callback' => 'services#create'
  devise_for :users
  resources :services, :only => [:index, :create, :destroy]
  
  mount Ckeditor::Engine => '/ckeditor'
  opinio_model
  resources :activities
  match 'activites/import_excel' => 'activities#import_excel'
  resources :categories
  resources :districts
  resources :excel_files
  resources :implementer_units
  match 'posts/update_districts' => 'posts#update_districts'
  match 'posts/update_subdistricts' => 'posts#update_subdistricts'
  match 'posts/update_activities' => 'posts#update_activities'
  resources :posts do
    opinio
  end
  resources :projects
  resources :provinces
  resources :subdistricts

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
