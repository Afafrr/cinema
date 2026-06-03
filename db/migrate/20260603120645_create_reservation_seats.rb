class CreateReservationSeats < ActiveRecord::Migration[8.1]
  def change
    create_table :reservation_seats do |t|
      t.references :reservation, null: false, foreign_key: true
      t.references :screening, null: false, foreign_key: true
      t.references :seat, null: false, foreign_key: true

      t.timestamps
    end

    add_index :reservation_seats, [ :screening_id, :seat_id ], unique: true
  end
end
