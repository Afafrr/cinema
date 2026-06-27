require "rails_helper"

RSpec.describe "Reservations", type: :request do
  let(:movie) { Movie.create!(title: "Movie 1", duration_minutes: 120) }
  let(:room) { Room.create!(name: "Screenings Request Spec Room") }
  let(:starts_at) { Time.current }
  let(:screening) do
    Screening.create!(
      movie: movie,
      room: room,
      starts_at: starts_at,
      ends_at: starts_at + movie.duration_minutes.minutes,
      price: 25
    )
  end
  let(:customer) { User.create!(email: "customer@example.com", password: "password123", role: "customer") }

  describe "GET /screenings" do
    it "unauthenticated - redirects user to sign in page" do
      get screening_url(screening)

      expect(response).to redirect_to(new_user_session_path)
    end
    it "authenticated - it does allow user to go to screening" do
      sign_in customer
      get screening_url(screening)

      expect(response).to have_http_status(200)
    end
  end
end
