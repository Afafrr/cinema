class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
    @screenings = @movie.screenings.order(:starts_at)
  end
end
