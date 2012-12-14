Qwiki::Application.routes.draw do
  devise_for :users

  resources :pages

  match "homes/help" => "homes#help"
  root :to => "homes#index"
end
