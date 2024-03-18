Rails.application.routes.draw do
  get 'main/index' => "main#index"
  get "main/new" => "main#new"
  post "main/create" => "main#create"
  get "main/:id" => "main#show"
  post "main/:id/destroy" => "main#destroy"
  get "main/:name/hashtag" => "main#hashtag"
  get "main/:id/comment" => "main#comment"
  post "main/:id/reply" => "main#reply"
  get "/" => "home#top"
  get "signup" => "users#new"
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  post "users/create" => "users#create"
  get "users/:id" => "users#mypage"
  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"
  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"
  post "favs/:user_id/follow" => "favs#follow"
  post "favs/:user_id/unfollow" => "favs#unfollow"
  get "favs/:id/followlist" => "favs#followlist"
  get "favs/:id/followerlist" => "favs#followerlist"
  get "searches/:name/user" => "searches#usersearch"
  post "searches/user_search" => "searches#user_search"
  get "searches/:post/post" => "searches#postsearch"
  post "searches/post_search" => "searches#post_search"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "users#login_form"
end
