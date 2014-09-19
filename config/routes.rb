Rails.application.routes.draw do
  root to: 'site#index'
  resources :site
  resources :game_templates
  match "*path", to: "site#index", via: "get"
end
