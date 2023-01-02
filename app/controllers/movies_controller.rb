class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
    @actors = @movie.actors.sort_by_age
    @average_age = @actors.average_age
  end
end