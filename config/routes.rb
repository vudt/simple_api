Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do 
    namespace :v1 do 
      # devise_for :users
      devise_for :users, :skip => [:registration]
      resources :users
      resources :posts
      get "user/sign_out" => "users#sign_out"
    end
  end
end
