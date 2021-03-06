BlogNagamemo::Application.routes.draw do
  resources :materials do
    member do
      get :now
    end
  end

  resources :histories do
    member do
      get :materials
    end
  end

  resources :offline_download_records do
    member do
      get :log
      get :status
      get :download
    end
  end

#   get "sessions/new"
#   get "sessions/create"
#   get "sessions/destroy"
#   get "static_page/home"
#   get "static_page/about"
	#   resources :comments

	resources :users do
		resources :comments
    resources :offline_download_records
		resources :posts do
			resources :comments
		end
	end


	resources :posts do
		resources :comments
	end

	resources :comments
  resources :file_records
	resources :sessions
	# The priority is based upon order of creation: first created -> highest priority.
	# See how all your routes lay out with "rake routes".

	# You can have the root of your site routed with "root"
	root 'posts#index'
	match 'about', to: 'static_page#about', via: 'get'
	match 'sign_up', to: 'users#new', via: 'get'
	match 'edit_me', to: 'users#edit_current_user', via: 'get'
	match 'show_me', to: 'users#show_current_user', via: 'get'
	match 'sign_in', to: 'sessions#new', via: 'get'
	match 'sign_out', to: 'sessions#destroy', via: 'delete'
	match 'quick_new_post' ,to:'posts#quick_new', via: 'post'
  match 'search', to: 'posts#search', via: 'get'
  match 'set_portrait', to:'users#set_portrait_img', via: 'post'
  match 'lunar_date', to: 'static_page#lunar_date', via: 'get'


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
