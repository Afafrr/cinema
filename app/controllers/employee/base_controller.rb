class Employee::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :require_employee

  private

  def require_employee
    unless current_user.role == "employee"
      redirect_to movies_path, alert: "You are not allowed to access this page."
    end
  end
end
