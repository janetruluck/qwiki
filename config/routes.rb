Qwiki::Application.routes.draw do
  resources :pages


  root :to => "homes#index"
end
