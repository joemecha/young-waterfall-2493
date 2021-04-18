 Rails.application.routes.draw do
  root to: "studios#index"

  resources :studios, only: [:show] do
    resources :movies, only: [:show]
  end

  post '/movies/:movie_id/actor_movies', to: 'actor_movies#create', as: 'new_actor_movies'

end
