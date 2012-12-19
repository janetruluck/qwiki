Qwiki::Application.routes.draw do
  devise_for :users

  resources :pages

  match "tag/:tag" => "pages#index", :as => "tags"
  match "pages/:id/history" => "pages#history", :as => "history_page"
  match "homes/help" => "homes#help"
  match "history/:id/diff" => "pages#diff", :as => "diff_page"
  root :to => "homes#index"
end
