Rails.application.routes.draw do
  get 'social/meetup'

  get 'social/closest'

#routes should be fairly self-explanatory.
  get 'browser/beers'
  get 'browser/pubs'
  #get 'browser/load'#No longer needed
  get 'browser/showLoaded'
  get 'browser/styles'
  get 'welcome/index'

  get 'social/groups'

  #http://stackoverflow.com/questions/34575953/ruby-on-rails-update-current-user
  #resource :user, path: "", only: [:edit, :update]
  #http://stackoverflow.com/questions/34575953/ruby-on-rails-update-current-user

  resources :users
  resources :breweries do
    resources :beers
  end
  root 'welcome#index'
  #temporary homepage

  #create a new user
  get '/signup' => 'users#new'
  get '/users' => 'users#create'

  #create new group
  get '/groups' => 'social#groups'
  post '/groups' => 'social#create'
  get '/group/:id' => 'social#group'

  # these routes are for showing users a login form, logging them in, and logging them out.
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/beers' => 'browser#beers'
  get '/pubs' => 'browser#pubs'
  get '/pub/:id' => 'browser#pub'
  get '/style/:id' => 'browser#style'
  get '/load' => 'browser#load'
  get '/showLoaded' => 'browser#showLoaded'
  get '/styles' => 'browser#styles'
  #get '/meetup' => 'social#meetup'
  get '/meetup' => 'social#closest'

  #facebook and google login
  get '/auth/:provider/callback' => 'sessions#createfb'
  get 'auth/failure', to: redirect('sessions#new')

  match 'users/:id/ban', :to => 'users#ban', :as => 'user_ban', :via => :post
  match 'users/:id/admin', :to => 'users#admin', :as => 'user_admin', :via => :post


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
