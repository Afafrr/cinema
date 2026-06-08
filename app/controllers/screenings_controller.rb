class ScreeningsController < ApplicationController
  before_action :authenticate_user!

  def show
    @screening = Screening.find(params[:id])
    @room = @screening.room

    seats_ordered = @room.seats.order(:row_no, :seat_no)
    @seats_by_row = seats_ordered.group_by { |seat| seat.row_no }

    puts @seats
  end
end
