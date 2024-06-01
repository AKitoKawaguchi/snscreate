Rails.application.routes.draw do
  get 'main/index' => "main#index"
  post "main/create" => "main#create"
  get "main/:id" => "main#show"
  post "main/:id/destroy" => "main#destroy"
  get "main/:name/hashtag" => "main#hashtag"
  get "main/:post_id/comment" => "main#comment"
  post "main/:id/reply" => "main#reply"
  get "/" => "home#top"
  get "start" => "users#start"
  get "signup" => "users#new"
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  post "users/:user_id/delete" => "users#delete_decision"
  post "users/create" => "users#create"
  get "users/:id" => "users#mypage"
  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"
  get "users/:id/train" => "users#train"
  post "users/:id/train_form" => "users#train_form"
  get "users/:recode_id/train_edit" => "users#train_edit"
  post "users/:recode_id/recode_edit" => "users#recode_edit"
  post "users/:recode_id/train_destroy" => "users#train_destroy"
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
  get "notifications/index" => "notifications#index"
  get "notifications/nofound" => "notifications#nofound"
  get "notifications/:id" => "notifications#show"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "users#login_form"
end
