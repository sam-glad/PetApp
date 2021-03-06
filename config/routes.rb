Rails.application.routes.draw do
  namespace :api do
    resources :users, except: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :organization_memberships, only: [:index]
      resources :admin_pet_applications, only: [:index]
    end
    resources :organization_memberships, except: [:index, :new, :edit, :destroy]
    resources :pet_applications, except: [:index, :new, :edit]
    resources :organizations, except: [:new, :edit] do
      resources :pet_applications, only: [:index]
      resources :application_forms, only: [:index]
    end
    resources :application_forms, except: [:index, :new, :edit]
    resources :organizations, except: [:new, :edit]
    resources :pets, except: [:create, :new, :edit, :destroy]
    resources :application_forms, except: [:new, :edit]
  end

  mount_devise_token_auth_for 'User', at: 'auth'
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
