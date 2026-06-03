class CreateScreenings < ActiveRecord::Migration[8.1]
  def change
    create_table :screenings do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.datetime :starts_at, null: false
      t.integer :price, null: false

      t.timestamps
    end
  end
end
