class CreateReservations < ActiveRecord::Migration[8.1]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :screening, null: false, foreign_key: true
      t.string :status, null: false, default: "active"

      t.timestamps
    end
  end
end
