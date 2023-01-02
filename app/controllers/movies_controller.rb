class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
    @actors = @movie.actors.sort_by_age
    @average_age = @actors.average_age
  end

  def update
    movie = Movie.find(params[:id])
    actor = Actor.find(params[:actor_id])
    ActorMovie.create!(actor: actor, movie: movie)

    redirect_to "/movies/#{movie.id}"
  end
end