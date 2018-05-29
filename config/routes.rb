Myapp::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users
  
  resources 'articles', only: [:show, :new, :create, :edit, :update, :destroy] do 
  	resources 'comments'
  end
  
  get '/articles/:id/step/:step', to: 'articles#step', as: :step_article
  get '/articles/:article_id/comments/new/:parent_id', to: 'comments#new', as: :new_comment

  root 'articles#index'
end
