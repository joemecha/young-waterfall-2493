class ActorMoviesController < ApplicationController

  def create
    # actor = Actor.find(params[:actor_name]) # NOPE not getting to data needed
    actor = Actor.find_by(name: params[:actor_name])

    movie = Movie.find(params[:movie_id])
    ActorMovie.create(actor: actor, movie: movie)

    redirect_to "/studios/#{movie.studio.id}/movies/#{movie.id}"
  end
end
