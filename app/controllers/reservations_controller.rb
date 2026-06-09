class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = current_user.reservations.includes(reservation_seats: :seat, screening: [:movie, :room])
  end

  def create
    seat_ids = params[:seat_ids] || []
    screening_id = params[:screening_id]

    if seat_ids.blank?
      redirect_to screening_path(screening_id), alert: "No seats selected."
      return
    end

    ActiveRecord::Base.transaction do
      reservation = Reservation.create!(
        user: current_user,
        screening_id: screening_id,
        status: "active",
      )

      seat_ids.each do |seat|
        ReservationSeat.create!(
          reservation: reservation,
          screening_id: screening_id,
          seat_id: seat,
        )
      end
    end

    redirect_to screening_path(screening_id), notice: "Reservation created successfully."
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique
    redirect_to screening_path(screening_id), alert: "One of the selected seats is no longer available."
  end

  def destroy
    reservations = current_user.reservations.where(screening_id: params[:screening_id])

    if reservations.present?
      reservations.destroy_all
      redirect_to reservations_path, notice: "Reservations cancelled successfully."
    else
      redirect_to reservations_path, alert: "Reservation not found."
    end
  end
end
