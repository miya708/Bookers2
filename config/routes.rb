Rails.application.routes.draw do

  devise_for :users


  resources :books
  resources :users, only: [:new,:show,:create,:edit,:index,:update,:destro]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 
  root to:"homes#top"
  get "about" => "homes#about"
#get '/url' => 'コントローラー名#アクション名'
  delete "books/:id" => "books#destroy", as: "destroy_book"


end
