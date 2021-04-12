class ActorMoviesController < ApplicationController

  def create
    actor = Actor.find(params[:actor_id])
    movie = Movie.find(params[:movie_id])
    ActorMovie.create(actor: actor, movie: movie)

    redirect_to "/studios/#{studio.id}/movies/#{movie.id}"
  end
end
