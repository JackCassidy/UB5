Rails.application.routes.draw do


  resources :peptide_proteins


  get "static_pages/home", :as => 'welcome_page'

  get "static_pages/help"

  get "static_pages/data_options"

  devise_for :users
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  get '/proteins/select_file', to: 'proteins#select_file'
  get '/infiles/select', to: 'infiles#select'
  get '/proteins/confirm_delete_all', to: 'proteins#confirm_delete_all'
  get '/peptides/confirm_delete_all', to: 'peptides#confirm_delete_all'
  post '/proteins/upload', to: 'proteins#upload'
  post '/proteins/delete_all', to: 'proteins#delete_all'
  post '/proteins/select_file', to: 'proteins#select_file'


  resources :proteins #, only: [:get, :show]




# trying to get rails_admin running
  root to:'static_pages#home'

  get '/peptides/select_peptide_file', to: 'peptides#select_peptide_file'
  post '/peptides/load', to: 'peptides#select_peptide_file'
  post '/peptides/upload', to: 'peptides#upload'
  post '/peptides/read_file', to: 'peptides#read_file'
  post '/peptides/delete_all', to: 'peptides#delete_all'
  post '/peptides/find_proteins', to: 'peptides#find_proteins'
  resources :peptides


  post '/peptide_protein/parsimony', to: 'peptide_proteins#parsimony'
  resources :peptide_proteins

  resources :infiles



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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

__END__
UB5::Application.routes.draw do



  resources :peptide_proteins


  get "static_pages/home", :as => 'welcome_page'

  get "static_pages/help"

  get "static_pages/data_options"

  devise_for :users
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  get '/proteins/select_file', to: 'proteins#select_file'
  post '/proteins/upload', to: 'proteins#upload'
  post '/proteins/delete_all', to: 'proteins#delete_all'
  resources :proteins #, only: [:get, :show]




  # trying to get rails_admin running
  root to:'static_pages#home'

  get '/peptides/select_peptide_file', to: 'peptides#select_peptide_file'
  post '/peptides/load', to: 'peptides#select_peptide_file'
  post '/peptides/upload', to: 'peptides#upload'
  post '/peptides/read_file', to: 'peptides#read_file'
  post '/peptides/delete_all', to: 'peptides#delete_all'
  post '/peptides/find_proteins', to: 'peptides#find_proteins'
  resources :peptides


  post '/peptide_protein/parsimony', to: 'peptide_proteins#parsimony'
  resources :peptide_proteins

  resources :infiles
  post '/infiles/new_protein_file', to: 'infiles#new_protein_file'

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

