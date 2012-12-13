Qwiki::Application.routes.draw do
  resources :pages

  match "homes/help" => "homes#help"

  root :to => "homes#index"
end
