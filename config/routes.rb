OpgLpa::Application.routes.draw do

  root "content#homepage"

  get '/help' => 'content#guidance'

  resources :lpas do
    get '/preview_pdf' => 'lpas#preview_pdf'
    get '/get_pdf' => 'lpas#get_pdf'
    get '/pdf' => 'lpas#pdf'

    resources :build, controller: 'lpas/build'
    resources :registration, controller: 'lpas/registration'
    collection do
      get :find
    end
    resources :attorneys
    resources :replacement_attorneys
    resources :people_to_be_told
  end

  resources :applicants, only: [:new, :create]

  namespace 'users' do
    get  '/sign_up' => 'registrations#new',    as: :new_registration
    post '/'        => 'registrations#create', as: :registration

    get '/confirmations/:confirmation_token' => 'confirmations#show'

    get  '/sign_in' => 'sessions#new',    as: :new_session
    post '/sign_in' => 'sessions#create', as: :session
    delete '/sign_out' => 'sessions#destroy', as: :destroy_session
  end

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
