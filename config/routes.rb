Qwiki::Application.routes.draw do
  devise_for :users

  resources :pages

  match "pages/:id/history" => "pages#history", :as => "history_page"
  match "homes/help" => "homes#help"
  root :to => "homes#index"
end
