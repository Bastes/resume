ActionController::Routing::Routes.draw do |map|
  map.resources :items do |item|
    item.resources :items, :as => 'children'
  end

  map.root :controller => 'items'
end
