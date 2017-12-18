Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  resources :categories
  resources :movies do
  	resources :reviews
  end
  devise_for :users
  get 'welcome/index'
  root 'welcome#index'
  resources :ranking
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
