require "rails_helper"
RSpec.describe "/employee/movies", type: :request do
  let(:customer_attributes) do
    {
      email: "customer@example.com",
      password: "password123",
      role: "customer"
    }
  end

  let(:employee_attributes) do
    {
      email: "employee@example.com",
      password: "password123",
      role: "employee"
    }
  end

  let(:valid_movie) do
    {
      title: "The Matrix",
      duration_minutes: 136,
      description: "A programmer discovers the truth about reality."
    }
  end

  let(:invalid_movie) do
    {
      title: "",
      duration_minutes: nil,
      description: "Missing required fields"
    }
  end

  let(:updated_movie) do
    {
      title: "The Matrix Reloaded",
      duration_minutes: 138,
      description: "Neo continues discovering the truth."
    }
  end

  describe "GET /employee/movies" do
    it "redirects unauthenticated users to sign in page" do
      get employee_movies_url

      expect(response).to redirect_to(new_user_session_path)
    end

    it "allows employee to access employee movies" do
      user = User.create! employee_attributes
      sign_in user

      get employee_movies_url

      expect(response).to be_successful
    end

    it "does not allow customer to access employee movies" do
      user = User.create! customer_attributes
      sign_in user

      get employee_movies_url

      expect(response).to redirect_to(movies_path)
    end
  end

  describe "GET /employee/movies/new" do
    it "allows employee to access new movie form" do
      user = User.create! employee_attributes
      sign_in user

      get new_employee_movie_url

      expect(response).to be_successful
    end
  end

  describe "GET /employee/movies/:id/edit" do
    it "allows employee to access edit movie form" do
      user = User.create! employee_attributes
      movie = Movie.create! valid_movie
      sign_in user

      get edit_employee_movie_url(movie)

      expect(response).to be_successful
    end
  end

  describe "POST /employee/movies" do
    it "creates a movie with valid data" do
      user = User.create! employee_attributes
      sign_in user

      expect do
        post employee_movies_url, params: { movie: valid_movie }
      end.to change(Movie, :count).by(1)

      expect(response).to redirect_to(employee_movies_path)
    end

    it "does not create a movie with invalid data" do
      user = User.create! employee_attributes
      sign_in user

      expect do
        post employee_movies_url, params: { movie: invalid_movie }
      end.not_to change(Movie, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "does not allow customer to create a movie" do
      user = User.create! customer_attributes
      sign_in user

      expect do
        post employee_movies_url, params: { movie: valid_movie }
      end.not_to change(Movie, :count)

      expect(response).to redirect_to(movies_path)
    end
  end

  describe "PATCH /employee/movies/:id" do
    it "updates a movie with valid data" do
      user = User.create! employee_attributes
      movie = Movie.create! valid_movie
      sign_in user

      patch employee_movie_url(movie), params: { movie: updated_movie }

      expect(response).to redirect_to(employee_movies_path)
      expect(movie.reload.title).to eq("The Matrix Reloaded")
      expect(movie.duration_minutes).to eq(138)
    end

    it "does not update a movie with invalid data" do
      user = User.create! employee_attributes
      movie = Movie.create! valid_movie
      sign_in user

      patch employee_movie_url(movie), params: { movie: invalid_movie }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(movie.reload.title).to eq("The Matrix")
      expect(movie.duration_minutes).to eq(136)
    end

    it "does not allow customer to update a movie" do
      user = User.create! customer_attributes
      movie = Movie.create! valid_movie
      sign_in user

      patch employee_movie_url(movie), params: { movie: updated_movie }

      expect(response).to redirect_to(movies_path)
      expect(movie.reload.title).to eq("The Matrix")
      expect(movie.duration_minutes).to eq(136)
    end
  end

  describe "DELETE /employee/movies/:id" do
    it "destroys a movie" do
      user = User.create! employee_attributes
      movie = Movie.create! valid_movie
      sign_in user

      expect do
        delete employee_movie_url(movie)
      end.to change(Movie, :count).by(-1)

      expect(response).to redirect_to(employee_movies_path)
    end

    it "does not allow customer to destroy a movie" do
      user = User.create! customer_attributes
      movie = Movie.create! valid_movie
      sign_in user

      expect do
        delete employee_movie_url(movie)
      end.not_to change(Movie, :count)

      expect(response).to redirect_to(movies_path)
    end
  end
end
