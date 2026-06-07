class Employee::MoviesController < Employee::BaseController
  before_action :set_employee_movie, only: [ :show, :edit, :update, :destroy ]

  # GET /employee/movies or /employee/movies.json
  def index
    @employee_movies = Movie.all
  end

  # GET /employee/movies/new
  def new
    @employee_movie = Movie.new
  end

  # POST /employee/movies or /employee/movies.json
  def create
    @employee_movie = Movie.new(employee_movie_params)
    if @employee_movie.save
      redirect_to employee_movies_path, notice: "Movie was successfully created."
    else
      flash[:alert] = @employee_movie.errors.full_messages.first
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /employee/movies/1 or /employee/movies/1.json
  def update
    if @employee_movie.update(employee_movie_params)
      redirect_to employee_movies_path, notice: "Movie was successfully updated."
    else
      flash[:alert] = @employee_movie.errors.full_messages.first
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /employee/movies/1 or /employee/movies/1.json
  def destroy
    if @employee_movie.destroy
      redirect_to employee_movies_path, notice: "Movie was successfully deleted."
    else
      redirect_to employee_movies_path, alert: @employee_movie.errors.full_messages.first
    end
  end

  private

  def set_employee_movie
    @employee_movie = Movie.find(params[:id])
  end

  def employee_movie_params
    params.require(:movie).permit(:title, :duration_minutes, :description)
  end
end
