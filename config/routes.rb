Rails.application.routes.draw do |map|   
  get "content/about"

  get "content/contact"

  resources :stores
  resources :products
  
  root :to => "stores#index"

  match '/sitemap', :controller => 'sitemap', :action => :index
  match '/feed', :controller => 'stores', :action => :feed
end
