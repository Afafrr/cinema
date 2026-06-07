require "rails_helper"

RSpec.describe "Employee dashboard", type: :request do
  describe "GET /employee" do
    it "redirects unauthenticated users to sign in page" do
      get employee_dashboard_path

      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects customers to root path" do
      customer = User.create!(
        email: "customer@example.com",
        password: "password123",
        role: "customer"
      )

      sign_in customer

      get employee_dashboard_path

      expect(response).to redirect_to(movies_path)
    end

    it "allows employees to access dashboard" do
      employee = User.create!(
        email: "employee@example.com",
        password: "password123",
        role: "employee"
      )

      sign_in employee

      get employee_dashboard_path

      expect(response).to have_http_status(:ok)
    end
  end
end
