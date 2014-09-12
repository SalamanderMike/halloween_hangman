Rails.application.routes.draw do
  resource :site
  match "*path", to: "site#index", via: "get"
  root to: 'site#index'
end
