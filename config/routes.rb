ActionController::Routing::Routes.draw do |map|
  map.resources :labels

  map.resources :reviews
  map.resources :ratings
<<<<<<< HEAD:config/routes.rb
  map.resources :albums, :member => { :select => :get, :review => :get, :create_review => :get }
=======
  map.resources :albums, :member => { :select => :get, :review => :get}
>>>>>>> 2fe5b96893c2280282e598f7b9b532e22f05eddb:config/routes.rb
  map.resources :artists
  
  # Restful static pages
  map.with_options :controller => 'contents' do |contents|
    contents.about 'about', :action => 'about'
    contents.contact 'contact', :action => 'contact'
    contents.terms 'terms', :action => 'terms'
    contents.help 'help', :action => 'help'
  end
 
  # Restful Authentication Rewrites
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  map.forgot_password '/forgot_password', :controller => 'passwords', :action => 'new'
  map.change_password '/change_password/:reset_code', :controller => 'passwords', :action => 'reset'
  map.open_id_complete '/opensession', :controller => "sessions", :action => "create", :requirements => { :method => :get }
  map.open_id_create '/opencreate', :controller => "users", :action => "create", :requirements => { :method => :get }
  
  # Restful Authentication Resources
  map.resources :users, :collection => { :admin => :get } do |users|
    users.resources :roles
  end
  map.resources :passwords
  map.resource :session
  
  # Home Page
  map.root :controller => 'contents', :action => 'front'

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
