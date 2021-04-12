Rails.application.routes.draw do
  root to: "studios#index"

  resources :studios do
    resources :movies, only: [:show]
  end
end
