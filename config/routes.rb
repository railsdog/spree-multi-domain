Spree::Core::Engine.add_routes do
  namespace :admin do
    resources :stores
  end
end
