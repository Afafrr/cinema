class CreateSeats < ActiveRecord::Migration[8.1]
  def change
    create_table :seats do |t|
      t.references :room, null: false, foreign_key: true
      t.integer :row_no, null: false
      t.integer :seat_no, null: false

      t.timestamps
    end

    add_index :seats, [:room_id, :row_no, :seat_no], unique: true
  end
end
