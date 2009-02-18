ActionController::Routing::Routes.draw do |map|
  map.resource :showcase, :plural => :showcase

  map.resources :sessions

  map.resources :items do |item|
    item.resources :items, :as => 'children'
  end

  map.root             :controller => 'showcase', :action => 'show'
  map.login  'login',  :controller => "sessions", :action => 'new'
  map.logout 'logout', :controller => "sessions", :action => 'destroy'
end
